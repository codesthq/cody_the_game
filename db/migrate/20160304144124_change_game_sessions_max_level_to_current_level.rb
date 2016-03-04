class ChangeGameSessionsMaxLevelToCurrentLevel < ActiveRecord::Migration
  def change
    rename_column :game_sessions, :max_level, :current_level
  end
end
