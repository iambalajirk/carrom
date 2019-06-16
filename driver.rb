require_relative './event_simulations'
require_relative './game/manager'
require_relative './event_handler'
require_relative './player/constants'
require 'json'

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
  player_one_length = simulation[player_one].length
  player_two_length = simulation[player_two].length

  game_completed = false

  until game_completed
    # Handle player one events.
    while !game_completed && player_one_index < player_one_length
      puts

      # Call event.
      event = simulation[player_one][player_one_index]
      event_type = event[0]
      event_args = event[1]
      event_handler.handle(event_type, event_args)

      # Check for game completion.
      if game_manager.completed
        game_completed = true
        game_manager.print_winner
        break
      end

      # Move to next event if present.
      player_one_index += 1
      if player_one_index == player_one_length
        puts "No more events left for #{player_one}..."
        break
      end

      # Check to continue player's turn or hand over the turn to the next player.
      continue_turn = game_manager.continue_turn?(event_type, player_one, event_args)
      if continue_turn
        puts "Continuing #{player_one}'s turn..."
      else
        puts "#{player_one}'s turn ends..."
        break
      end
    end

    # Handle player two events.
    while !game_completed && player_two_index < player_two_length
      puts

      # Call event.
      event = simulation[player_two][player_two_index]
      event_type = event[0]
      event_args = event[1]
      event_handler.handle(event_type, event_args)

      # Check for game completion.
      if game_manager.completed
        game_completed = true
        game_manager.print_winner
        break
      end

      # Move to next event if present.
      player_two_index += 1
      if player_two_index == player_two_length
        puts "No more events left for #{player_two}..."
        break
      end

      # Check to continue player's turn or hand over the turn to the next player.
      continue_turn = game_manager.continue_turn?(event_type, player_two, event_args)
      if continue_turn
        puts "Continuing #{player_two}'s turn..."
      else
        puts "#{player_two}'s turn ends..."
        break
      end
    end

    break if (player_two_index >= player_two_length) && (player_one_index >= player_one_length)
  end

  puts
  puts 'GAME OVER !!!'
end
