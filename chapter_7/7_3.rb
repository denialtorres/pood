module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= Schedule.new
  end

  # Return true if this bicycle is avaiable
  # during this (now Bicycle specific) interval
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # includers may override
  def lead_days
    0
  end
end


class Schedule
  def scheduled?(schedulable, starting, ending)
    puts "This #{schedulable.class} is " +
         " avaiable #{starting} - #{ending}"
  end
end

class Bicycle
  include Schedulable

  attr_reader :size, :chain, :tire_size


  # Inject the Schedule and provide default
  def initialize(**opts)
  end

  # Return the number of lead_days before a bicycle
  # can be scheduled
  def lead_days
    1
  end
end

require 'date'

starting = Date.parse('2019/09/04')
ending = Date.parse("2019/09/10")

b = Bicycle.new
puts b.schedulable?(starting, ending)
