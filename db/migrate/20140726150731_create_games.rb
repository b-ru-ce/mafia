class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :number
      t.date :date
      t.integer :game_role_type_id

      t.timestamps
    end
  end
end
