# Responsibility
# Receives the event, Validate the event, perform the event by calling game_manager, print the status after the event.
class EventHandler
    attr_accessor :game_manager

    def initialize(game_manager)
        @game_manager = game_manager
    end


    # For each of the event, 
    # 1. perform the event.
    # 2. Print status after the event.
    def handle(event, args={})
        performed_by = args.delete(:performed_by)
        return unless game_manager.validate_event(performed_by, event, args)

        puts "Received (#{event} event), Performed By: #{performed_by}, Options: #{args.inspect}"
        game_manager.send("handle_#{event}_event", performed_by, args)
        puts "Completed (#{event} event)"
        
        puts "Status......"
        game_manager.status
    end
end