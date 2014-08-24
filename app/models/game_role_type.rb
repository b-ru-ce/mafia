class GameRoleType < ActiveRecord::Base
  has_many :game_roles
  has_many :games
end

# == Schema Information
#
# Table name: game_role_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
