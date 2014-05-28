class AddUsefullToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :usefull, :boolean
  end
end
