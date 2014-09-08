class AddRatingToGamers < ActiveRecord::Migration
  def change
    add_column :gamers, :rating, :float
  end
end
