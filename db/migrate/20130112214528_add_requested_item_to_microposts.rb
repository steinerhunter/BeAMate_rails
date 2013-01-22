class AddRequestedItemToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :requested_item, :string
  end
end
