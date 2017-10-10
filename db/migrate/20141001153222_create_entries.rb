class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :customer_id
      t.integer :event_id
      t.text :post
      t.string :gift

      t.timestamps
    end
  end
end
