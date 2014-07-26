class CreateGameRoles < ActiveRecord::Migration
  def change
    create_table :game_roles do |t|
      t.integer :game_role_type_id
      t.string :name

      t.timestamps
    end
  end
end
