class RemoveTaskIdFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :task_id, :integer
  end
end
