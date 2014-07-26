class CreateGameRoleTypes < ActiveRecord::Migration
  def change
    create_table :game_role_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
