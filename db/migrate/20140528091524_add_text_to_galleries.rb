class AddTextToGalleries < ActiveRecord::Migration
  def change
    add_column :photo_galleries, :text, :text
    add_column :photo_galleries, :date, :date
  end
end
