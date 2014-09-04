class AddSumPointsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :sum_points, :float
  end
end
