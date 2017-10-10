class Event < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :gifts, dependent: :delete_all
  has_many :collectors
end
