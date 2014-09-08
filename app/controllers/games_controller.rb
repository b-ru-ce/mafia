# -*- encoding : utf-8 -*-
class GamesController < ApplicationController

  def new
    @game = Game.new date: Date.today()
    authorize! :create, @game

    10.times do |i|
      @game.gamers.new number: (i+1)
    end
  end

  def create
    authorize! :create, Game
    @game = Game.create date: params[:game][:date], game_role_type_id: params[:game][:game_role_type_id]

    params[:game][:gamers_attributes].each do |key, gamer|
      @game.gamers.create number: gamer[:number], member_id: gamer[:member_id], game_role_id: gamer[:game_role_id],
                         first_die: gamer[:first_die], guess_2: gamer[:guess_2], guess_3: gamer[:guess_3]
    end

    redirect_to games_url(@game), notice: 'Игра создана.'
  end

  def update
    @game = Game.find(params[:id])
    authorize! :edit, @game

    @game.update_attributes game_role_type_id: params[:game][:game_role_type_id]


    params[:game][:gamers_attributes].each do |key, gamer|
      @game.gamers.where(number: gamer[:number]).first.update_attributes member_id: gamer[:member_id], game_role_id: gamer[:game_role_id],
                          first_die: gamer[:first_die], guess_2: gamer[:guess_2], guess_3: gamer[:guess_3]
    end

    redirect_to edit_game_url(@game), notice: 'Игра сохранена.'
  end

  def edit
    @game = Game.find(params[:id])
    authorize! :edit, @game

    render 'new'
  end

  def index
    @games = Game.today
  end

  def show
    @game = Game.find(params[:id])
    authorize! :read, @game
  end

  def rating
    first_die_count = 10
    mafia_plus_count = 40
    mafia_minus_count = 20
    citizen_plus_count = 30
    citizen_minus_count = 15
    commissar_plus_count = 50
    commissar_minus_count = 25
    don_plus_count = 50
    don_minus_count = 25
    gamers = {}

    piece = GameRole.find_by_name('мирный').id
    commissar = GameRole.find_by_name('шериф').id
    don = GameRole.find_by_name('дон').id
    mafia = GameRole.find_by_name('мафия').id

    winner_piece = GameRoleType.find_by_name('мирные').id
    winner_mafia = GameRoleType.find_by_name('мафия').id

    game_piece = Game.where(game_role_type_id: winner_piece).pluck(:id)
    game_mafia = Game.where(game_role_type_id: winner_mafia).pluck(:id)


    members = {}

    Member.all.each do |member|
      gamers = member.gamers
      members[member.id] = member

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
      member.rating = first_die_count * member.first_die_count

      member.sum_points = member.win_game_piece_count * 3 +
          member.win_game_commissar_count * 4 +
          (member.game_commissar_count - member.win_game_commissar_count) * (-1) +
          (member.game_don_count - member.win_game_don_count) * (-1) +
          member.win_game_don_count * 5 +
          member.win_game_mafia_count * 4 +
          gamers.where(guess_2: true).count * 0.5 +
          gamers.where(guess_3: true).count

      member.save
    end

    Game.all.each do |game|

      mafia_rating = 0
      citizen_rating = 0
      game.gamers.each do |gamer|
        member = members[gamer.member_id]

        mafia_rating += member.rating if gamer.game_role_id == mafia || gamer.game_role_id == don
        citizen_rating += member.rating if gamer.game_role_id == mafia || gamer.game_role_id == commissar
      end

      mafia_rating = (mafia_rating/3.0)
      citizen_rating = (citizen_rating/7.0)
      logger.debug mafia_rating
      logger.debug citizen_rating
      k = 1000
      # k = (mafia_rating + citizen_rating)*5 + 1
      mafia_elo =  1.0/(1+10**((citizen_rating-mafia_rating)/k))
      citizen_elo =  1.0/(1+10**((mafia_rating-citizen_rating)/k))

      game.gamers.each do |gamer|
        member = members[gamer.member_id]

        if game.game_role_type_id == mafia
          member.rating += 2*mafia_plus_count*(1-mafia_elo)  if gamer.game_role_id == mafia
          member.rating += 2*don_plus_count*(1-mafia_elo)  if gamer.game_role_id == don
          member.rating -= 2*citizen_minus_count*citizen_elo  if gamer.game_role_id == piece
          member.rating -= 2*commissar_minus_count*citizen_elo  if gamer.game_role_id == commissar
        else

          member.rating -= 2*mafia_minus_count*mafia_elo  if gamer.game_role_id == mafia
          member.rating -= 2*don_minus_count*mafia_elo  if gamer.game_role_id == don
          member.rating += 2*citizen_plus_count*(1-citizen_elo)  if gamer.game_role_id == piece
          member.rating += 2*commissar_plus_count*(1-citizen_elo)  if gamer.game_role_id == commissar
        end
        if member.rating < 0
          member.rating = 0
        end

      end
    end

    members.each do |key,member|
      member.save
    end

    redirect_to "/rating"
  end


end
