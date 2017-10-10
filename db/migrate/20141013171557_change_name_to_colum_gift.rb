class ChangeNameToColumGift < ActiveRecord::Migration
  def change
    rename_column :gifts, :type, :type_g
  end
end
