module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def gear_inches
      # wheel an object that respond to diameter
      ratio * wheel.diameter
    end

    def ratio
      chainring / cog.to_f
    end
  end
end

# wrap  the framework to protect your self from changes
module GearWrapper
  def self.gear(chainring:, cog:, wheel:)
    SomeFramework::Gear.new(chainring, cog, wheel)
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


# now you can create a new Gear usng keyword arguments

puts GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)).gear_inches
