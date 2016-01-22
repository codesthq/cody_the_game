class AddTestClassToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :test_class, :string
    change_column_null :tasks, :test_class, false, "Challenge::HelloWorld"
  end
end
