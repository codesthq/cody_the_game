class AddEmailToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :email, :string
  end
end
