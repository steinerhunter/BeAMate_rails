class AddDepartingOnToMateposts < ActiveRecord::Migration
  def change
    add_column :mateposts, :departing_on, :string
  end
end
