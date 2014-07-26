class Gamer < ActiveRecord::Base
  belongs_to :member
  belongs_to :game_role
  belongs_to :game

  validates :game_role_id, presence: true
  validates :member_id, presence: true
  validates :number, presence: true
end
