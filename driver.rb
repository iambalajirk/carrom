require_relative './sample_input'
require_relative './game/manager'
require_relative './event_handler'
require 'json'

include SampleInput

simulations.each_with_index do |simulation, index|
    puts "------------------------------------------------------------------------"
    # puts "------------------------------------------------------------------------"
    puts "                            Simulation No ##{index + 1}                 "
    puts "------------------------------------------------------------------------"

    game_manager = Game::Manager.new
    puts "Initial status..."
    game_manager.status
    event_handler = EventHandler.new(game_manager)

    simulation.each_with_index do |event, i|
        begin
            puts
            puts "Event ##{i+1}"
            type = event[0]
            args = event[1]

            event_handler.handle(type, args)
            if game_manager.completed
                game_manager.print_winner
                break
            end
        rescue StandardError => e
            puts "Exception in performing event, error: #{e.message}, trace: #{e.backtrace}"
        end
    end

    puts "------------------------------------------------------------------------"
    puts
end
