class AddPositionToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :position, :integer, default: 0
  end
end
