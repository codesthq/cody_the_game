class AddStartCodeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :start_code, :text
    change_column :tasks, :content, :text
  end
end
