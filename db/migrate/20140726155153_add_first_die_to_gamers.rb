class AddFirstDieToGamers < ActiveRecord::Migration
  def change
    add_column :gamers, :first_die, :boolean
  end
end
