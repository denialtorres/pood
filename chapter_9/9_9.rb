require 'minitest/spec'
require 'minitest/autorun'

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]      || default_chain
    @tire_size  = opts[:tire_size]  || default_tire_size
    post_initialize(opts)
  end

  def spares
    { tire_size: tire_size,
      chain: chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts); end

  def local_spares
    {}
  end

  def default_chain
    '11-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(opts)
    @front_shock = opts[:front_shock]
    @rear_shock  = opts[:rear_shock]
  end

  def spares
    { front_shock: front_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class BikeDouble < Bicycle
  def default_tire_size
    0
  end

  def local_spares
    { saddle: 'painful' }
  end
end

module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_respons_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_respons_to_size
    assert_respond_to(@object, :size)
  end

  def test_respons_to_tire_size
    assert_respond_to(@object, :tire_size)
  end

  def test_respons_to_spares
    assert_respond_to(@object, :spares)
  end
end

module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new(tire_size: 0)
    @double = BikeDouble.new
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) { @bike.default_tire_size }
  end

  def test_includes_local_spares_in_spares
    assert_equal @double.spares,
                 tire_size: 0,
                 chain: '11-speed',
                 saddle: 'painful'
  end
end

class RoadBikeTest < Minitest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end

  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end

class MountainBikeTest < Minitest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new
  end
end

class BikeDoubleTest < Minitest::Test
  include BicycleSubclassTest

  def setup
    @bike = @object = BikeDouble.new
  end
end
