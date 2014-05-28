class CreatePhotoGalleries < ActiveRecord::Migration
  def change
    create_table :photo_galleries do |t|
      t.text :title
      t.integer :sort
      t.string :ancestry
      t.string :title_of_window
      t.text :meta

      t.timestamps
    end
  end
end
