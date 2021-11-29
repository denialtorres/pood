class Bicycle
  attr_reader :style, :size,
              :tape_color,
              :front_shock, :rear_shock

  def initialize(**opts)
    @style = opts[:style]
    @size = opts[:size]
    @tape_color = opts[:tape_color]
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  # checking 'style' start down a slippery slope
  def spares
    if style == :road
      {
        chain: '11-speed',
        tire_size: '23', # millimeters
        tape_color: tape_color
      }
    else
      {
        chain: '11-speed',
        tire_size: '2.1', # inches
        front_shock: front_shock
      }
    end

    # .....
  end
end
bike = Bicycle.new(
  style: :montain,
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
)

puts bike.spares

bike = Bicycle.new(
  style: :road,
  size: 'M',
  tape_color: 'red'
)

puts '---------------'
puts bike.spares
