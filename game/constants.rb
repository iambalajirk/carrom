require_relative '../coin/constants'

module Game
  module Constants
    include Coin::Constants
    
    EVENTS = {
      STRIKE: 'strike',
      MULTI_STRIKE: 'multi_strike',
      RED_STRIKE: 'red_strike',
      STRIKER_STRIKE: 'striker_strike',
      DEFUNCT_COIN: 'defunct_coin',
      MISSED_STRIKE: 'missed_strike'
    }.freeze

    EVENT_TYPES = EVENTS.values.freeze

    MISSES_LIMIT = 3
    FOULS_LIMIT = 3

    MINIMUM_POINTS_TO_WIN = 5
    MINIMUM_DIFFERENCE_TO_WIN = 3

    INCREMENT_POINTS = {
      COIN_TYPES[:black] => 1,
      COIN_TYPES[:red] => 3,
      :multi_strike => 2
    }.freeze

    DECREMENT_POINTS = {
      defunct_coin: 2,
      striker_strike: 1,
      missed_strike: 1,
      fouls: 1
    }.freeze

    MAXIMUM_DISCARD_COINS = {
      multi_strike: 2
    }.freeze

    MESSAGES = {
      not_enough_coins: '(Invalid event) Not enough %{coin_type} coins to perform event...',
      coin_type_not_present: '(Invalid event) Coin type not present',
      not_enough_coins_multi_strike: '(Invalid event) Not enough coins in multistrike event.',
      decrement_point_for_misses: 'Decrementing a point as %{player} has done %{limit} misses and resetting misses....',
      decrement_point_for_fouls: 'Decrementing a point as %{player} has commited %{limit} new fouls and resetting fouls....',
      result: "%{winner} won the game. Final score: %{winner_points} - %{loser_points}",
      draw: "Game is a draw",
      unregistered_event: "Invalid event. Event not registered.",
      received_event: "Received (%{event} event), Performed By: %{performed_by}, Options: %{args}",
      completed_event: "Completed (%{event} event)"
    }.freeze
  end
end
