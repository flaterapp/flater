class AddAvatarUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_url, :string, default: 'https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1145&q=80'
  end
end
