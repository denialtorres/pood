class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size
  end

  def default_chain # <- common default
    "11-speed"
  end

  def default_tire_size
    # explicity stating that subclasses are required
    # to implement default_tire_size in his own subclass
    raise NotImplementedError,
          "#{self.class} should have implemented"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super # < - RoadBike MUST send 'super'
  end

  def default_tire_size # <- subclass default
    "23"
  end

  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
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

  def default_tire_size # <- subclass default
    "2.1"
  end

  def spares
    super.merge(front_shock: front_shock)
  end
end

class RecumbentBike < Bicycle
  def default_chain
    '10-speed'
  end
end

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
)

puts road_bike.tire_size
puts road_bike.chain

puts '-----------------'

mountain_bike = MountainBike.new(
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
)

puts mountain_bike.tire_size

puts mountain_bike.chain

puts '-----------------'
bent = RecumbentBike.new(size: "L")
puts bent
