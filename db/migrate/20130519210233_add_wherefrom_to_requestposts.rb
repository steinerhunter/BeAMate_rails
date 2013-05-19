class AddWherefromToRequestposts < ActiveRecord::Migration
  def change
    add_column :requestposts, :wherefrom, :string
  end
end
