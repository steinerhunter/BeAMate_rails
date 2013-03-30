class ChangeDataTypeForMatepostsDate < ActiveRecord::Migration
  def up
    remove_column :mateposts, :departing_on
    add_column        :mateposts, :departing_on, :datetime
    remove_column :mateposts, :returning_on
    add_column        :mateposts, :departing_on, :datetime
  end

  def down
    remove_column :mateposts, :departing_on
    add_column        :mateposts, :departing_on, :string
    remove_column :mateposts, :returning_on
    add_column        :mateposts, :departing_on, :string
  end
end
