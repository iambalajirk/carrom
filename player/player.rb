module Player
    class Player
        attr_accessor :name, :points, :fouls, :misses

        def initialize(options = {})
            @name = options[:name]
            @points = 0
            @fouls = 0
            @misses = 0
        end

        def details
            {
                name: name,
                points: points,
                fouls: fouls,
                misses: misses
            }
        end
    end
end