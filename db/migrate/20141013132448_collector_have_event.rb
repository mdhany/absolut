class CollectorHaveEvent < ActiveRecord::Migration
  def change
    add_column :collectors, :event_id, :integer
  end
end
