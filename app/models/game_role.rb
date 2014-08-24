class GameRole < ActiveRecord::Base
  belongs_to :game_role_type
  has_many :gamers
end

# == Schema Information
#
# Table name: game_roles
#
#  id                :integer          not null, primary key
#  game_role_type_id :integer
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
