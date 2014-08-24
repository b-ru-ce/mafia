class Member < ActiveRecord::Base
  has_many :gamers

  validates :nick, presence: true
  validates :gender, presence: true
end

# == Schema Information
#
# Table name: members
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  nick                     :string(255)
#  phone                    :string(255)
#  vk                       :string(255)
#  email                    :string(255)
#  gender                   :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  rating                   :float
#  game_count               :integer
#  win_game_count           :integer
#  game_piece_count         :integer
#  win_game_piece_count     :integer
#  game_commissar_count     :integer
#  win_game_commissar_count :integer
#  game_mafia_count         :integer
#  win_game_mafia_count     :integer
#  game_don_count           :integer
#  win_game_don_count       :integer
#  first_die_count          :integer
#  birthday                 :date
#
