# Responsibilities:
# Stores the list of players.
# Manages player and their possible actions.

require_relative './player'
require_relative './constants'

module Player
    class Manager
        include Constants
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
            sorted_players = players.sort_by {|name, value| value.points}.reverse.to_h
            player = sorted_players.values
            leader = player[0]
            trailer = player[1]

            { leader: leader.details, trailer: trailer.details }
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

        def reset_fouls(player)
            player = get_player(player)

            player.fouls = 0
        end

        def get_player(name)
            return players[name] unless players[name].nil?
            
            @players[name] = Player.new({name: name})
        end
    end
end