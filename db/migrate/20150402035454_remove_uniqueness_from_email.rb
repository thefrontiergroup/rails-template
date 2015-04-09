class RemoveUniquenessFromEmail < ActiveRecord::Migration
  def change
    # Remove the existing unique email index
    remove_index :users, :email
    add_index :users, :email
  end
end
