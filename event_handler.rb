require_relative './game/constants'
# Receives the event, Validate the event, perform the event by calling game_manager, print the status after the event.
class EventHandler
    include Game::Constants

    attr_accessor :game_manager

    def initialize(game_manager)
        @game_manager = game_manager
    end

    # Only event name or the args as well.
    def valid_event(event, args)
        EVENT_TYPES.include? event
    end

    # For each of the events received, 
    # Perform the event and print status after the event.
    def handle(event, args={})
        return unless valid_event(event, args)

        performed_by = args.delete(:performed_by)

        puts "Received (#{event} event), Performed By: #{performed_by}, Options: #{args.inspect}"
        game_manager.send("handle_#{event}_event", performed_by, args)
        puts "Completed (#{event} event)"
        
        game_manager.print_status
    end

end