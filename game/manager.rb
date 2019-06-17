# Manages the game
# Contains the game logic.
require_relative './events'
require_relative './constants'
require_relative './validator'
require_relative '../coin/manager'
require_relative '../player/manager'

module Game
  class Manager
    include Events
    include Constants
    include Validator

    attr_accessor :coin_manager, :player_manager

    def initialize(_options = {})
      @coin_manager = Coin::Manager.new
      @player_manager = Player::Manager.new
    end

    def process_event(event, performed_by, args)
      return unless valid_event?(event, performed_by, args)

      send("handle_#{event}_event", performed_by, args)
      print_status
    end

    # Check game is completed or not?
    def completed?
      return true if coin_manager.total_coins_left <= 0

      status = player_manager.leader_trailer_status
      leader = status[:leader]
      trailer = status[:trailer]

      someone_won = (leader[:points] >= MINIMUM_POINTS_TO_WIN && leader[:points] - trailer[:points] >= MINIMUM_DIFFERENCE_TO_WIN)
      someone_won ? true : false
    end

    def print_status
      puts 'Player stats....'
      player_manager.statuses.each do |player|
        player.each { |key, value| print "#{key.upcase}: #{value} | " }
        puts
      end

      puts 'Coin stats....'
      coin_manager.statuses.each do |coin|
        coin.each { |key, value| print "#{key.upcase}: #{value} | " }
        puts
      end
    end

    def final_message
      puts
      status = player_manager.leader_trailer_status
      leader = status[:leader]
      trailer = status[:trailer]

      if coin_manager.total_coins_left <= 0
        if leader[:points] >= MINIMUM_POINTS_TO_WIN || leader[:points] - trailer[:points] >= MINIMUM_DIFFERENCE_TO_WIN
          puts MESSAGES[:result] % { winner: leader[:name], winner_points: leader[:points], loser_points: trailer[:points]}
        else
          puts MESSAGES[:draw]
        end
      else
        puts MESSAGES[:result] % { winner: leader[:name], winner_points: leader[:points], loser_points: trailer[:points]}
      end
    end

    private

    def valid_event?(event, performed_by, args)
      if respond_to?("validate_#{event}_event", true)
        send("validate_#{event}_event", performed_by, args) == false ? false : true
      else
        true
      end
    end
  end
end
