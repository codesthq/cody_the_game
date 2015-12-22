class AddLevelIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :level_id, :integer, null: false
  end
end
