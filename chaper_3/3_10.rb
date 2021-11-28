class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring: 40, cog: 18, wheel: )
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    # wheel an object that respond to diameter
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
end


puts Gear.new(wheel: Wheel.new(26, 15)).chainring
