class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.integer :conversation_id
      t.string :description

      t.timestamps null: false
    end
  end
end
