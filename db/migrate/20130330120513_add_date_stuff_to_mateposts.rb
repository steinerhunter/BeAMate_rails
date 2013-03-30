class AddDateStuffToMateposts < ActiveRecord::Migration
  def up
    add_column        :mateposts, :departing_on, :datetime
    add_column        :mateposts, :departing_on, :datetime
  end

  def down
    remove_column :mateposts, :departing_on
    remove_column :mateposts, :returning_on
  end
end
