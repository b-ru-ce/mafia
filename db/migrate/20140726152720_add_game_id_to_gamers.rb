class AddGameIdToGamers < ActiveRecord::Migration
  def change
    add_column :gamers, :game_id, :integer
  end
end
