class RemoveConversationIdFromLevels < ActiveRecord::Migration
  def change
    remove_column :levels, :conversation_id, :integer
  end
end
