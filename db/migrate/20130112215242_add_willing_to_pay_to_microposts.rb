class AddWillingToPayToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :willing_to_pay, :string
  end
end
