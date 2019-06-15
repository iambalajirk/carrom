# Manages the game
# Contains the game logic.
require_relative './events'
require_relative './constants'
require_relative '../coin/manager'
require_relative '../player/manager'

module Game
    class Manager
        include Events
        include Constants

        attr_accessor :coin_manager, :player_manager

        def initialize(options={})
            @coin_manager = Coin::Manager.new
            @player_manager = Player::Manager.new
        end

        def status
            player_manager.statuses.each do |player|
                puts "PLAYER: #{player[:name]}, Points: #{player[:points]}, Fouls: #{player[:fouls]}, Misses: #{player[:misses]}"
            end

            coin_manager.statuses.each do |coin|
                puts "COIN: #{coin[:type]}, left: #{coin[:count]}"
            end
        end

        def completed
            return true if coin_manager.total_coins_left <= 0

            status = player_manager.leader_trailer_status
            leader, trailer = status[:leader], status[:trailer]

            someone_won = (leader[:points] >= MINIMUM_POINTS_TO_WIN && leader[:points] - trailer[:points] >= MINIMUM_DIFFERENCE_TO_WIN)
            someone_won ? true : false
        end

        def print_winner
            puts
            status = player_manager.leader_trailer_status
            leader, trailer = status[:leader], status[:trailer]

            if coin_manager.total_coins_left <= 0
                if leader[:points] >= MINIMUM_POINTS_TO_WIN || leader[:points] - trailer[:points] >= MINIMUM_DIFFERENCE_TO_WIN
                    puts "#{leader[:name]} won the game. Final score: #{leader[:points]} - #{trailer[:points]}"
                else
                    puts "Game is a draw"
                end
            else
                puts "#{leader[:name]} won the game. Final score: #{leader[:points]} - #{trailer[:points]}"
            end
        end
        
    end
end