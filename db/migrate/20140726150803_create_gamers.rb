class CreateGamers < ActiveRecord::Migration
  def change
    create_table :gamers do |t|
      t.integer :number
      t.integer :member_id
      t.integer :game_role_id
      t.boolean :guess_2
      t.boolean :guess_3

      t.timestamps
    end
  end
end
