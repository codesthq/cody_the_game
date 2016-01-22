class AddGameSessionIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :game_session_id, :integer, null: false
  end
end
