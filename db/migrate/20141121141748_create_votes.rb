class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :dj_id
      t.integer :customer_id

      t.timestamps
    end
    add_column :customers, :vote_id, :integer
  end
end
