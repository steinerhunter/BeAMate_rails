class Feedback < ActiveRecord::Migration
  def change
    create_table :feedback do |t|
      t.string :name
      t.string :email
      t.string :body

      t.timestamps
    end
  end
end
