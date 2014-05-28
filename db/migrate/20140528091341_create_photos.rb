class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photo_gallery_id
      t.string :image_uid
      t.text :description
      t.integer :sort
      t.string :ancestry
      t.boolean :main

      t.timestamps
    end
  end
end
