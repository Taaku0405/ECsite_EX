class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_one_attached :item_image
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join("app/assets/images/noimage.jpg")
      item_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpg")
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
  
    # 消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end
  
    #検索機能の定義
  def self.looks(search, word)
    if search == "完全一致"
      @item = Item.where("name LIKE?", "#{word}")
    elsif search == "曖昧検索"
      @item = Item.where("name LIKE?", "%#{word}%")
    else
      @item = Item.all
    end
  end
  
end
