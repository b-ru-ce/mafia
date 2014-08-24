class ChangeRatingFromMembers < ActiveRecord::Migration
  def change
    change_column :members, :rating, :float
  end
end
