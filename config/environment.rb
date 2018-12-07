# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Mafia::Application.initialize!


Mafia::Application.configure do

  FIRST_DIE_COUNT = 10
  MAFIA_PLUS_COUNT = 40
  MAFIA_MINUS_COUNT = 20
  CITIZEN_PLUS_COUNT = 30
  CITIZEN_MINUS_COUNT = 15
  COMMISSAR_PLUS_COUNT = 50
  COMMISSAR_MINUS_COUNT = 25
  DON_PLUS_COUNT = 50
  DON_MINUS_COUNT = 25

  GUESS_2 = 5
  GUESS_3 = 10


  PIECE = 1
  COMMISSAR = 3
  DON = 4
  MAFIA = 2

  WINNER_PIECE = PIECE
  WINNER_MAFIA = MAFIA
end
