class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :abbreviation, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
