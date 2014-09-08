class RemoveSumPointsFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :sum_points, :string
  end
end
