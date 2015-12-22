class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :level,   null: false
      t.string     :content, null: false
      t.integer    :points,  null: false

      t.timestamps null: false
    end
  end
end
