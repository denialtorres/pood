gem 'minitest', '~>5'
require 'minitest/autorun'
require 'minitest/pride'

class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
end

# when you introduce TripCoordinator and Driver

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)
    # ....
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end

  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ...
  end
end

# if you happen to pass an instance of *this* class it works

class Mechanic

  def prepare_trip(trip)
    trip.bicycles.each do |bicycle|
      prepare_bicycle(bicycle)
    end
  end

  def prepare_bicycle(bicycle)
    # .....
  end
end

module PreparerInterfaceTest
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end


class MechanicTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end
  # the other test will rely on @mechanic
end

class TripCoordinatorTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

class DriveTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

class TripTest < Minitest::Test
  def test_request_trip_preparation
    @preparer = Minitest::Mock.new
    @trip = Trip.new

    @preparer.expect(:prepare_trip, nil, [@trip])

    @trip.prepare([@preparer])
    @preparer.verify
  end
end
