class Member < ActiveRecord::Base
  include PathWithAlias

  has_many :gamers

  dragonfly_accessor :avatar

  validates :nick, presence: true
  validates :gender, presence: true

  default_scope {order('nick')}

  def nick_with_gender
    "#{gender} #{nick}"
  end

  def html_title
    MyConfig.get_config('default_title') + ' - ' + nick_with_gender
  end
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
#  avatar_uid               :string(255)
#
