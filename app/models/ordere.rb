class Ordere < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details
  
  validates :postal_code, presence: true, length: {maximum: 7}
  validates :address, presence: true
  validates :name, presence: true
  
  enum method_of_payment: {credit_card: 0, transfer: 1}
  enum shipping_address: {my_address: 0, registered_address: 1, new_address: 2}
  enum order_status: {customer_payment: 0, payment_confirmed: 1, production: 2, preparation: 3, shipped: 4}
  
  def total
    order_details.sum(:amount)
  end
  
end
