class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.text :title
      t.string :image_uid
      t.text :text
      t.string :url
      t.integer :sort
      t.string :ancestry

      t.timestamps
    end
  end
end
