class AddRatingToMembers < ActiveRecord::Migration
  def change
    add_column :members, :rating, :integer
    add_column :members, :game_count, :integer
    add_column :members, :win_game_count, :integer
    add_column :members, :game_piece_count, :integer
    add_column :members, :win_game_piece_count, :integer
    add_column :members, :game_commissar_count, :integer
    add_column :members, :win_game_commissar_count, :integer
    add_column :members, :game_mafia_count, :integer
    add_column :members, :win_game_mafia_count, :integer
    add_column :members, :game_don_count, :integer
    add_column :members, :win_game_don_count, :integer
    add_column :members, :first_die_count, :integer
  end
end
