require 'pry'
require 'forwardable'
require 'ostruct'

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

#----- parts factory
module PartsFactory
  def self.build(config:, parts_class: Parts)
    parts_class.new(
      config.collect { |part_config| create_part(part_config) }
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name: part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end

# ---- testing

mountain_bike = Bicycle.new(
  size: 'L',
  parts: PartsFactory.build(config: mountain_config)
)

puts mountain_bike.spares.class

puts mountain_bike.spares


puts 'finish'
