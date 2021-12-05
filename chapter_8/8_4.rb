require 'pry'
require 'forwardable'

#---- config variables
road_config = [
  ['chain', '11-speed'],
  %w[tire_size 23],
  %w[tape_color red]
]

mountain_config = [
  ['chain', '11-speed'],
  ['tire_size', '2.1'],
  %w[front_shock Manitou],
  ['rear_shock', 'Fox', false]
]


class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size = size
    @parts = parts
  end

  def spares
    parts.spares
  end
end

class Parts
  extend Forwardable

  def_delegators :@parts, :size, :each

  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select(&:needs_spare)
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(name:, description:, needs_spare: )
    @name = name
    @description = description
    @needs_spare = needs_spare
  end
end


#----- parts factory
module PartsFactory
  def self.build(
    config:,
    part_class: Part,
    parts_class: Parts
  )

    parts_class.new(
      config.collect do |part_config|
        part_class.new(
          name: part_config[0],
          description: part_config[1],
          needs_spare: part_config.fetch(2, true)
        )
      end
    )
 end
end


class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(**opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    {
      tape_color: tape_color
    }
  end

  def default_tire_size
    '23'
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  def local_spares
    {
      front_shock: front_shock
    }
  end

  def default_tire_size
    '2.1'
  end
end

chain = Part.new(name: 'chain', description: '11-speed')

road_tire = Part.new(name: 'tire_size', description: '23')

tape = Part.new(name: 'tape_color', description: 'red')

mountain_tire = Part.new(name: 'tire_size', description: '2.1')

rear_shock = Part.new(name: 'rear_shock', description: 'Fox', needs_spare: false)

front_shock = Part.new(name: 'front_shock', description: 'Manitou')

road_bike = Bicycle.new(
  size: 'L',
  parts: Parts.new(
    [
      chain,
      road_tire,
      tape
    ]
  )
)

mountain_bike = Bicycle.new(
  size: 'L',
  parts: Parts.new(
    [
      chain,
      mountain_tire,
      front_shock,
      rear_shock
    ]
  )
)


puts 'finish'
