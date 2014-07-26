class Member < ActiveRecord::Base
  has_many :gamers

  validates :nick, presence: true
  validates :gender, presence: true
end
