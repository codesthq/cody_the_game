class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :task,    null: false
      t.text       :content, null: false
      t.integer    :status,  default: 0

      t.timestamps null: false
    end
  end
end
