gem 'minitest', '~>5'
require 'minitest/autorun'
require 'minitest/pride'

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def with # <----- used to be 'diameter'
    rim + (tire * 2)
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel= wheel
  end

  def gear_inches
    # the object in the 'wheel' variable
    # plays the Diameterizable role
    ratio * wheel.with # <-- obsolete
  end

  def ratio
    chainring / cog.to_f
  end
end

class WheelTest < Minitest::Test
  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.with,
                    0.01)
    end
  end

class GearTest < Minitest::Test
  def test_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: Wheel.new(26, 1.5)
    )

    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end
