class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
