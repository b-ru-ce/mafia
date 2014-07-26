# -*- encoding : utf-8 -*-
namespace :db do

  desc 'Rating'
  task :rating => :environment do

    piece = GameRole.find_by_name('мирный').id
    commissar = GameRole.find_by_name('шериф').id
    don = GameRole.find_by_name('дон').id
    mafia = GameRole.find_by_name('мафия').id

    winner_piece = GameRoleType.find_by_name('мирные').id
    winner_mafia = GameRoleType.find_by_name('мафия').id

    game_piece = Game.where(game_role_type_id: winner_piece).pluck(:id)
    game_mafia = Game.where(game_role_type_id: winner_mafia).pluck(:id)

    Member.all.each do |member|
      gamers = member.gamers
      
      member.game_piece_count = gamers.where(game_role_id: piece).count
      member.win_game_piece_count = gamers.where(game_role_id: piece).where(game_id: game_piece).count
      member.game_commissar_count = gamers.where(game_role_id: commissar).count
      member.win_game_commissar_count = gamers.where(game_role_id: commissar).where(game_id: game_piece).count
      member.game_mafia_count = gamers.where(game_role_id: mafia).count
      member.win_game_mafia_count = gamers.where(game_role_id: mafia).where(game_id: game_mafia).count
      member.game_don_count = gamers.where(game_role_id: don).count
      member.win_game_don_count = gamers.where(game_role_id: don).where(game_id: game_mafia).count
      member.first_die_count = gamers.where(first_die: true).count

      member.game_count = member.game_piece_count + member.game_commissar_count + member.game_mafia_count + member.game_don_count
      member.win_game_count = member.win_game_piece_count + member.win_game_commissar_count + member.win_game_mafia_count + member.win_game_don_count

      member.rating = member.win_game_piece_count * 3 +
          member.win_game_commissar_count * 4 +
          (member.game_commissar_count - member.win_game_commissar_count) * (-1) +
          (member.game_don_count - member.win_game_don_count) * (-1) +
          member.win_game_don_count * 5 +
          member.win_game_mafia_count * 3 +
          gamers.where(guess_2: true).count * 0.5 + 
          gamers.where(guess_3: true).count

      member.save
    end

  end
end