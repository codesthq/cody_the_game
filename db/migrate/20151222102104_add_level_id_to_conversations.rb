class AddLevelIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :level_id, :integer
  end
end
