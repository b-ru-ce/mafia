class Gamer < ActiveRecord::Base
  belongs_to :member
  belongs_to :game_role
  belongs_to :game

  validates :game_role_id, presence: true
  validates :member_id, presence: true
  validates :number, presence: true
end

# == Schema Information
#
# Table name: gamers
#
#  id           :integer          not null, primary key
#  number       :integer
#  member_id    :integer
#  game_role_id :integer
#  guess_2      :boolean
#  guess_3      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  game_id      :integer
#  first_die    :boolean
#
