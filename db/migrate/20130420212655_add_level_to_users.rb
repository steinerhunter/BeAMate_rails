class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mate_level, :integer, :default => 1
  end
end
