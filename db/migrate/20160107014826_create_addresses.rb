class CreateAddresses < ActiveRecord::Migration
  def change
    add_column :sites, :address_id, :integer, null: false

    create_table :addresses do |t|
      t.string :line_1, null: false
      t.string :line_2
      t.string :city
      t.integer :state_id, null: false
      t.string :post_code, null: false

      t.timestamps null: false
    end
  end
end
