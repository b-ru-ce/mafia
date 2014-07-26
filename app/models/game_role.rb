class GameRole < ActiveRecord::Base
  belongs_to :game_role_type
  has_many :gamers
end
