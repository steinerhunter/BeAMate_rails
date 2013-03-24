class ChangeDataTypeForMatepostsDate < ActiveRecord::Migration
  def up
    change_table :mateposts do |t|
      t.change :departing_on, :datetime
      t.change :returning_on, :datetime
    end
  end

  def down
    change_table :mateposts do |t|
      t.change :departing_on, :string
      t.change :returning_on, :string
    end
  end
end
