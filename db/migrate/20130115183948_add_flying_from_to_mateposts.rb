class AddFlyingFromToMateposts < ActiveRecord::Migration
  def change
    add_column :mateposts, :flying_from, :string
  end
end
