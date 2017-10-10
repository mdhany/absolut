class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :inventory
      t.integer :predicted
      t.integer :priority
      t.integer :event_id

      t.timestamps
    end
  end
end
