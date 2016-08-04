class AddSecureTokenToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :secure_token, :string, null: false
  end
end
