class GameRoleType < ActiveRecord::Base
  has_many :game_roles
  has_many :games
end
