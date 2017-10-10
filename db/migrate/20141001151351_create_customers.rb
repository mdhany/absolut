class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.date :birth
      t.string :city
      t.string :mobile
      t.string :email
      t.string :interest
      t.integer :entry_id

      t.timestamps
    end

    add_index :customers, :email, unique: true
  end
end
