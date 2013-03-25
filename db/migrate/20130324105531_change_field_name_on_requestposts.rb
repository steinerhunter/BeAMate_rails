class ChangeFieldNameOnRequestposts < ActiveRecord::Migration
  def up
    change_table :requestposts do |t|
      t.rename :willing_to_pay, :give_giftcards
    end
  end

  def down
    change_table :requestposts do |t|
      t.rename :give_giftcards, :willing_to_pay
    end
  end

end
