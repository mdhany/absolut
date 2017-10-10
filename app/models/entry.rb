class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :customer
  belongs_to :collector

  scope :completed, -> { where(completed: true) }
end
