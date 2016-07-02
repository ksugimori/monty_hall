# 
# @author ksugimori
module MontyHall
  # Monty Hall Problem Simulator
  # @author ksugimori
  class Simulator
    CAR = "car"
    GOAT = "goat"

    # Initialize counter to zero.
    # @param [Integer] sample_size number of trials
    def initialize(sample_size)
      @sample_size = sample_size
      @cnt_winning_the_car = 0
    end

    # Execute <sample_size> times
    def execute
      @sample_size.times do
        doors = [CAR, GOAT, GOAT].shuffle
        your_choice = choose_door

        # The host opens the door which has a goat.
        host_choice = choose_door exclude: [your_choice, doors.find_index(CAR)]

        # Switch your choice to the remaining door.
        your_choice = choose_door exclude: [your_choice, host_choice]

        @cnt_winning_the_car += 1 if doors[your_choice].eql? CAR
      end
    end

    # Show simulation results.
    def show_result
      percentage = (100.0 * @cnt_winning_the_car.to_f / @sample_size.to_f).round(1)
      puts "------------------------"
      puts "N = #{@sample_size}"
      puts "------------------------"
      puts "WIN : #{@cnt_winning_the_car} times."
      puts "LOSE: #{@sample_size - @cnt_winning_the_car} times."
      puts "------------------------"
      puts "By switching your choice to the remaining door, "
      puts "you got a #{percentage} percent winning rate!"
    end


    private

    # Randomly choose a door No. within 0 to 2. 
    # @param [Array] exclude A list to be excluded.
    # @return 0, 1, or 2.
    def choose_door(exclude: [])
      ([0, 1, 2] - exclude).sample
    end
  end
end