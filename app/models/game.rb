class Game < ActiveRecord::Base
  belongs_to :game_role_type

  has_many :gamers, dependent: :destroy
  accepts_nested_attributes_for :gamers, :allow_destroy => true

  scope :today, -> {where(date: Date.today())}

  def get_game_koef(members = nil)
    mafia_rating = 0
    citizen_rating = 0
    self.gamers.each do |gamer|
      if members
        member_r = members[gamer.member_id].rating
      else
        member_r = gamer.current_rating
      end

      mafia_rating += member_r if gamer.game_role_id == MAFIA || gamer.game_role_id == DON
      citizen_rating += member_r if gamer.game_role_id == PIECE || gamer.game_role_id == COMMISSAR
    end

    mafia_rating = (mafia_rating/3.0)
    citizen_rating = (citizen_rating/7.0)

    k = 1000

    mafia_elo =  1.0/(1+10**((citizen_rating-mafia_rating)/k))

    citizen_elo =  1.0/(1+10**((mafia_rating-citizen_rating)/k))

    return {mafia_elo:mafia_elo, citizen_elo:citizen_elo, mafia_rating:mafia_rating, citizen_rating:citizen_rating}
  end


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
