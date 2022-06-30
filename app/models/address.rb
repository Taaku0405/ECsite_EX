class Address < ApplicationRecord
  belongs_to :customer
  
  validates :postal_code, presence: true, length: {maximum: 7}
  validates :address, presence: true
  validates :name, presence: true
  
  def address_display #住所を〒から名前まで一行で表示する
    "〒" + postal_code + "" "" + address + "" "" + name
  end
  
end
