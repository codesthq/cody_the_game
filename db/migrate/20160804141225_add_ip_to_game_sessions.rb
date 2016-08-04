class AddIpToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :ip, :string
  end
end
