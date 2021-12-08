gem 'minitest', '~>5'
require 'minitest/autorun'
require 'minitest/pride'

class Gear
  attr_reader :chainring, :cog, :wheel, :observer

  def initialize(chainring:, cog:, wheel:, observer:)
    @chainring = chainring
    @cog = cog
    @wheel= wheel
    @observer = observer
  end

  def gear_inches
    # the object in the 'wheel' variable
    # plays the Diameterizable role
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end

  def set_cog(new_cog)
    @cog = new_cog
    changed
  end

  def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
  end

  def changed
    observer.changed(chainring, cog)
  end
end

class DiameterDouble
  def diameter
    10
  end
end

class GearTest < Minitest::Test
  def setup
    @observer = Minitest::Mock.new
    @gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new,
      observer: @observer
    )
  end

  def test_notifies_observers_when_cogs_change
    @observer.expect(:changed, true, [52, 27])
    @gear.set_cog(27)
    @observer.verify
  end

  def test_notifies_observers_when_chainrings_change
    @observer.expect(:changed, true, [42, 11])
    @gear.set_chainring(42)
    @observer.verify
  end
end
