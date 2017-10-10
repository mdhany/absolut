class Gift < ActiveRecord::Base
  belongs_to :event

  scope :in_stock, -> { where('inventory != 0') }
  scope :tin, -> { where(type_g: 5) }
end
