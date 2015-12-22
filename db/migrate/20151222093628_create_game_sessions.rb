class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.string :cookie_key, null: false
      t.integer :points, default: 0
      t.string :name
      t.integer :max_level, default: 0

      t.timestamps null: false
    end
  end
end
