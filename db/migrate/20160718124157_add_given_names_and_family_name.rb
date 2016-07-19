class AddGivenNamesAndFamilyName < ActiveRecord::Migration
  def change
    # The longest name in the world is 214 characters, so we go with 255 here:
    # Adolph Blaine Charles David Earl Frederick Gerald Hubert Irvin John Kenneth Lloyd Martin Nero Oliver Paul Quincy Randolph Sherman Thomas Uncas Victor William Xerxes Yancy Wolfeschlegelsteinhausenbergerdorff, Senior
    add_column :users, :given_names, :string, null: false, limit: 255
    add_column :users, :family_name, :string, null: false, limit: 255
  end
end
