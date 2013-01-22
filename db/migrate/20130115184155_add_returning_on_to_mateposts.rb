class AddReturningOnToMateposts < ActiveRecord::Migration
  def change
    add_column :mateposts, :returning_on, :string
  end
end
