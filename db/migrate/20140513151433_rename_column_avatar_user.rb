class RenameColumnAvatarUser < ActiveRecord::Migration
  def change
    rename_column :users, :facebook_avatar, :avatar
  end
end
