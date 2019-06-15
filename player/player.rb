module Player
    class Player
        attr_accessor :name, :points, :fouls, :misses, :skip_turns

        def initialize(options = {})
            @name = options[:name]
            @points = 0
            @fouls = 0
            @misses = 0
            @skip_turns = 0
        end

        def details
            {
                name: name,
                points: points,
                fouls: fouls,
                misses: misses,
                skip_turns: skip_turns
            }
        end
    end
end