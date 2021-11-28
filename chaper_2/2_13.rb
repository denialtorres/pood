class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  # first iterate over the array
  def diameters
    wheels.collect wheel do
      diameter(wheel)
    end
  end

  # second - calculate diameter of ONE wheel
  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  # now everyone can send rim/tire to wheel
  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
    data.collect cell do
      Wheel.new(cell[0], cell[1])
    end
  end
end
