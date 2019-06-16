require_relative './sample_input'
require_relative './game/manager'
require_relative './event_handler'
require_relative './player/constants'
require 'json'


include SampleInput
include Player::Constants

simulations.each_with_index do |simulation, index|
    puts "------------------------------------------------------------------------"
    puts "                            Simulation No ##{index + 1}                 "
    puts "------------------------------------------------------------------------"

    game_manager = Game::Manager.new
    event_handler = EventHandler.new(game_manager)
    puts "Initial status..."
    game_manager.status

    player_one = PLAYER[:ONE][:name]
    player_two = PLAYER[:TWO][:name]

    player_one_index = 0
    player_two_index = 0
    player_one_length = simulation[player_one].length
    player_two_length = simulation[player_two].length

    game_completed = false
    
    while(!game_completed)
        while(!game_completed && player_one_index < player_one_length)
            puts
            event = simulation[player_one][player_one_index]

            event_type, event_args = event[0], event[1]
            event_handler.handle(event_type, event_args)

            if game_manager.completed
                game_completed = true
                game_manager.print_winner
                break 
            end

            player_one_index += 1
            if event_handler.continue(event_type, event_args) && player_one_index < player_one_length
                puts "Continuing #{player_one}'s turn..." 
            else
                puts "#{player_one}'s turn ends..."
                break
            end
        end

        while(!game_completed && player_two_index < player_two_length)
            puts
            event = simulation[player_two][player_two_index]

            event_type, event_args = event[0], event[1]
            event_handler.handle(event_type, event_args)

            if game_manager.completed
                game_completed = true
                game_manager.print_winner
                break 
            end

            player_two_index += 1
            if event_handler.continue(event_type, event_args) && player_two_index < player_two_length
                puts "Continuing #{player_two}'s turn..." 
            else
                puts "#{player_two}'s turn ends..."
                break
            end
        end

        break if ( player_two_index >= player_two_length ) && ( player_one_index >= player_one_length)
    end

    puts
    puts "GAME OVER !!!"
end
