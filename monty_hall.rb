require './simulator'

simulator = MontyHall::Simulator.new(100_000)
simulator.execute
simulator.show_result