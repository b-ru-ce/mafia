class Game < ActiveRecord::Base
  belongs_to :game_role_type

  has_many :gamers, dependent: :destroy
  accepts_nested_attributes_for :gamers, :allow_destroy => true
end
