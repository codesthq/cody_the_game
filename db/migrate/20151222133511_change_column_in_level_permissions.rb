class ChangeColumnInLevelPermissions < ActiveRecord::Migration
  def change
    change_column :game_sessions, :max_level, :integer, default: 1
  end
end
