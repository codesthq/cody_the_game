class AddPositionToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :position, :integer, default: 0
  end
end
