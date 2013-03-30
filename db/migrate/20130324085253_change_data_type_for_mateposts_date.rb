class ChangeDataTypeForMatepostsDate < ActiveRecord::Migration
  def up
    remove_column :mateposts, :departing_on
    remove_column :mateposts, :returning_on
  end

  def down
    add_column        :mateposts, :departing_on, :string
    add_column        :mateposts, :departing_on, :string
  end
end
