class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :deadline
      t.string :title
      t.integer :price
      t.integer :title_id

      t.timestamps null: false
    end
  end
end
