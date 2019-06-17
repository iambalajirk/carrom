### Structure of the program.
> ruby driver.rb

to run the program.

Use `event_simulations.rb` to provide inputs. The method `simulations` returns an array of hashes. Each hash represents a simulation. Each hash has `player_1`, `player_2` details in an array. You can add more events inside `player_1`, `player_2` array to test.

##### Ruby version used
> ruby 2.2.3p173

### Running the tests
Run test by the following commands.
> `ruby tests/game/events_spec.rb`

> `ruby tests/game/validator_spec.rb`

Install the following gems if you have any issues in running the tests.
> gem install test-unit & gem install minitest

### Sample output
Checkout `output.txt` for the sample output.