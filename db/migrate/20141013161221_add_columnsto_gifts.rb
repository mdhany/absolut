class AddColumnstoGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :type, :integer
    add_column :gifts, :position, :integer
  end
end
