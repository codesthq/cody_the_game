class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation
      t.references :character
      t.string     :content

      t.timestamps null: false
    end
  end
end
