class AddFlyingToToMateposts < ActiveRecord::Migration
  def change
    add_column :mateposts, :flying_to, :string
  end
end
