class AddAvatarUidToMembers < ActiveRecord::Migration
  def change
    add_column :members, :avatar_uid, :string
  end
end
