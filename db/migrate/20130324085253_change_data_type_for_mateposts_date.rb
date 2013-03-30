class ChangeDataTypeForMatepostsDate < ActiveRecord::Migration
  def up
    remove_column :departing_on, :string
    add_column        :departing_on, :datetime
    remove_column :returning_on, :string
    add_column        :returning_on, :datetime
  end

  def down
    remove_column :departing_on, :datetime
    add_column        :departing_on, :string
    remove_column :returning_on, :datetime
    add_column        :returning_on, :string
  end
end
