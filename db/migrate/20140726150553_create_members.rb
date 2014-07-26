class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :nick
      t.string :phone
      t.string :vk
      t.string :email
      t.string :gender

      t.timestamps
    end
  end
end
