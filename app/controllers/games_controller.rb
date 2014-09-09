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



    gamers = {}




    game_piece = Game.where(game_role_type_id: WINNER_PIECE).pluck(:id)
    game_mafia = Game.where(game_role_type_id: WINNER_MAFIA).pluck(:id)


    members = {}

    Member.all.each do |member|
      gamers = member.gamers
      members[member.id] = member

      member.game_piece_count = gamers.where(game_role_id: PIECE).count
      member.win_game_piece_count = gamers.where(game_role_id: PIECE).where(game_id: game_piece).count
      member.game_commissar_count = gamers.where(game_role_id: COMMISSAR).count
      member.win_game_commissar_count = gamers.where(game_role_id: COMMISSAR).where(game_id: game_piece).count
      member.game_mafia_count = gamers.where(game_role_id: MAFIA).count
      member.win_game_mafia_count = gamers.where(game_role_id: MAFIA).where(game_id: game_mafia).count
      member.game_don_count = gamers.where(game_role_id: DON).count
      member.win_game_don_count = gamers.where(game_role_id: DON).where(game_id: game_mafia).count
      member.first_die_count = gamers.where(first_die: true).count

      member.game_count = member.game_piece_count + member.game_commissar_count + member.game_mafia_count + member.game_don_count
      member.win_game_count = member.win_game_piece_count + member.win_game_commissar_count + member.win_game_mafia_count + member.win_game_don_count
      member.rating = 0

      member.save
    end

    Game.all.each do |game|

      elo = game.get_game_koef members
      # citizen_elo =  0.5

      game.gamers.each do |gamer|
        member = members[gamer.member_id]

        if game.game_role_type_id == MAFIA
          gamer.rating = 2*MAFIA_PLUS_COUNT*(1-elo[:mafia_elo])  if gamer.game_role_id == MAFIA
          gamer.rating = 2*DON_PLUS_COUNT*(1-elo[:mafia_elo])  if gamer.game_role_id == DON
          gamer.rating = -2*CITIZEN_MINUS_COUNT*elo[:citizen_elo]  if gamer.game_role_id == PIECE
          gamer.rating = -2*COMMISSAR_MINUS_COUNT*elo[:citizen_elo]  if gamer.game_role_id == COMMISSAR
        else
          gamer.rating = -2*MAFIA_MINUS_COUNT*elo[:mafia_elo]  if gamer.game_role_id == MAFIA
          gamer.rating = -2*DON_MINUS_COUNT*elo[:mafia_elo]  if gamer.game_role_id == DON
          gamer.rating = 2*CITIZEN_PLUS_COUNT*(1-elo[:citizen_elo])  if gamer.game_role_id == PIECE
          gamer.rating = 2*COMMISSAR_PLUS_COUNT*(1-elo[:citizen_elo])  if gamer.game_role_id == COMMISSAR
        end

        gamer.rating += FIRST_DIE_COUNT if gamer.first_die
        gamer.rating += GUESS_2 if gamer.guess_2
        gamer.rating += GUESS_3 if gamer.guess_3

        gamer.current_rating = member.rating
        member.rating += gamer.rating

        if member.rating < 0
          gamer.rating = gamer.rating - member.rating
          member.rating = 0
        end

        gamer.save

      end
    end

    members.each do |key,member|
      member.save
    end

    redirect_to "/rating"
  end


end
