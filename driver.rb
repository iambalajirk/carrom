require_relative './event_simulations'
require_relative './game/manager'
require_relative './event_handler'
require_relative './player/constants'

include EVENT_SIMULATIONS
include Player::Constants

simulations.each_with_index do |simulation, index|
  puts '------------------------------------------------------------------------'
  puts "                            Simulation No ##{index + 1}                 "
  puts '------------------------------------------------------------------------'

  game_manager = Game::Manager.new
  event_handler = EventHandler.new(game_manager)
  puts 'Initial status...'
  game_manager.print_status

  player_one = PLAYER[:ONE][:name]
  player_two = PLAYER[:TWO][:name]

  player_one_index = 0
  player_two_index = 0
  player_one_events_length = simulation[player_one].length
  player_two_events_length = simulation[player_two].length

  game_completed = false
  
  begin
    until game_completed
      # Handle player one events.
      if !game_completed && player_one_index < player_one_events_length
        puts

        # Call event.
        event_row = simulation[player_one][player_one_index]
        event, args = event_row[0], event_row[1]
        performed_by = player_one
        event_handler.handle(event, performed_by, args)

        # Check for game completion.
        if game_manager.completed?
          game_completed = true
          game_manager.final_message
          break
        end

        # Move to next event if present.
        player_one_index += 1
      end

      # Handle player two events.
      if !game_completed && player_two_index < player_two_events_length
        puts

        # Call event.
        event_row = simulation[player_two][player_two_index]
        event, args = event_row[0], event_row[1]
        performed_by = player_two
        event_handler.handle(event, performed_by, args)

        # Check for game completion.
        if game_manager.completed?
          game_completed = true
          game_manager.final_message
          break
        end

        # Move to next event_row if present.
        player_two_index += 1
      end

      break if (player_two_index >= player_two_events_length) && (player_one_index >= player_one_events_length)
    end

    puts
    puts 'GAME OVER !!!'
  rescue StandardError => e
    puts "Exception in simulation #{index + 1}, error: #{e.message}, trace: #{e.backtrace}"
  end
end
