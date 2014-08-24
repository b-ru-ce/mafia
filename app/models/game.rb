class Game < ActiveRecord::Base
  belongs_to :game_role_type

  has_many :gamers, dependent: :destroy
  accepts_nested_attributes_for :gamers, :allow_destroy => true

  scope :today, -> {where(date: Date.today())}
end

# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  number            :integer
#  date              :date
#  game_role_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#
