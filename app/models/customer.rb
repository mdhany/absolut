class Customer < ActiveRecord::Base
  has_one :entry, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validate :birth, presence: true

  def self.get_customer(email)
    customer = find_by email: email
    if customer
      customer
    else
      nil
    end
  end

end
