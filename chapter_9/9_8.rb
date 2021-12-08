require 'minitest/spec'
require 'minitest/autorun'

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def width
    rim + (tire * 2)
  end
end

class DiameterDouble
  def width
    10
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.width
  end

  def ratio
    chainring / cog.to_f
  end
end


module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
   assert_respond_to(@object, :width)
  end
end

class WheelTest < Minitest::Test
  include DiameterizableInterfaceTest

  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_calculates_diameter
    # ...
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.width,
                    0.01)
  end
end

class DiameterDoubleTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest

  def setup
    @object = DiameterDouble.new
  end
end

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              wheel:     DiameterDouble.new)

    assert_in_delta(47.27,
                    gear.gear_inches,
                    0.01)
  end
end
