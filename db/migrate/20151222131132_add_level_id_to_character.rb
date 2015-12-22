class AddLevelIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :level_id, :integer, null: false
  end
end
