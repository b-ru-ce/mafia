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

    redirect_to edit_game_url(@game), notice: 'Игра создана. Вы можете продолжить ее редактирование.'
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

  end


end
