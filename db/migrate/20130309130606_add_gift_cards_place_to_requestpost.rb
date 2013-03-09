class AddGiftCardsPlaceToRequestpost < ActiveRecord::Migration
  def change
    add_column :requestposts, :giftCardsPlace, :string
  end
end
