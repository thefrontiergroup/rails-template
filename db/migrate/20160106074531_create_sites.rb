class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.boolean :rural

      t.timestamps null: false
    end

    add_column :users, :site_id, :integer
    add_index :users, :site_id
  end
end
