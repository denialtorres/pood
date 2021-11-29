class Bicycle
  attr_reader :size

  def initialize(**opts)
    @size = opts[:size] # <- promoted from RoadBike
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super # < - RoadBike MUST send 'super'
  end

  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end

  # Many other methods.....
end

class MountainBike < Bicycle
  # Still a subclass of bicycle
  # code has not changed

  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
    # the send of super in the line 8
    # invokes the initialize method of
    # Bicycle with opts as an argument
    super
  end

  def spares
    super.merge(front_shock: front_shock)
  end
end

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
)

puts road_bike.size

puts '-----------------'

mountain_bike = MountainBike.new(
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
)

puts mountain_bike.size

puts '--------------'
puts mountain_bike.spares
