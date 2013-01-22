class CreateMateposts < ActiveRecord::Migration
  def change
    create_table :mateposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :mateposts, [:user_id, :created_at]
  end
end
