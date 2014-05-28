class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :sort
      t.string :ancestry

      t.timestamps
    end
  end
end
