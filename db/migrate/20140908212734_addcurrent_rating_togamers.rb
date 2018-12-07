class AddcurrentRatingTogamers < ActiveRecord::Migration
  def change
    add_column :gamers, :current_rating, :float
  end
end
