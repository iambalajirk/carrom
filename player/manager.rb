# Responsibilities:
# Stores the list of players.
# Manages player and their possible actions.

require_relative './player'
require_relative './constants'
require_relative '../coin/constants'

module Player
    class Manager
        include Constants
        include Coin::Constants

        attr_accessor :players

        def initialize(options={})
            @players = {}

            (options[:players] || PLAYER) .each do |player, option|
                @players[option[:name]] = Player.new(option)
            end
        end

        def statuses
            players.map { |name, player| player.details }
        end

        def leader_trailer_status
            player = players.values
            player_one = player[0]
            player_two = player[1]

            if (player_one.points > player_two.points)
                { leader: player_one.details, trailer: player_two.details }
            else
                { leader: player_two.details, trailer: player_one.details }
            end
        end

        def details(name)
            player = get_player(name)

            player.details
        end

        def primary_coin(name)
            player = get_player(name)

            player.coins_allowed.find {|coin| coin != COIN_TYPES[:red]}
        end

        def all_players
            players.map {|name, player| player.details }
        end

        def handle_coins_pocketed(name, coin_type, coins_pocketed)
            player = get_player(name)

            player.coins_pocketed[coin_type] =  player.coins_pocketed[coin_type] + coins_pocketed
        end

        def increment_points(name, points=1)
            player = get_player(name)

            player.points += points
        end

        def decrement_points(name, points=1)
            player = get_player(name)

            player.points -= points
        end

        def increment_misses(name, count=1)
            player = get_player(name)

            player.misses += count
            player.misses
        end

        def reset_misses(name)
            player = get_player(name)
            player.misses = 0
        end

        def increment_fouls(name, count=1)
            player = get_player(name)

            player.fouls += count
            player.fouls
        end

        def reset_fouls(name)
            player = get_player(name)

            player.fouls = 0
        end

        def valid_action(name, coin_type)
            player = get_player(name)

            player.coins_allowed.include? coin_type
        end

        def get_player(name)
            return players[name] unless players[name].nil?
            
            @players[name] = Player.new({
                name: name, 
                coins_allowed: DEFAULT_COINS_ALLOWED, 
                coins_pocketed: DEFAULT_COINS_POCKETED
            })
        end
    end
end