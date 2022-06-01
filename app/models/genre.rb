class Genre < ApplicationRecord
  
  has_many :items

  validates :name, presence: true
  
  def self.looks(search, word)
    if search == "完全一致"
      @genre = Genre.where("name LIKE?", "#{word}")
    elsif search == "曖昧検索"
      @genre = Genre.where("name LIKE?", "%#{word}%")
    else
      @genre = Genre.all
    end
  end
end