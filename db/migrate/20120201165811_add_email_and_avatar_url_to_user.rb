class AddEmailAndAvatarUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :avatar_url, :string

  end
end
