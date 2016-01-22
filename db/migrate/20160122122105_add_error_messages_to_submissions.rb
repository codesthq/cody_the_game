class AddErrorMessagesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :error_messages, :string
  end
end
