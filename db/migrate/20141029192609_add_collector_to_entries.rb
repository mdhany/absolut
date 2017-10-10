class AddCollectorToEntries < ActiveRecord::Migration
  def change
    add_column :collectors, :name, :string
    add_column :entries, :collector_id, :integer

  end
end
