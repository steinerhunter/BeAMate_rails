class AddMatePointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mate_points, :integer, :default => 200
  end
end
