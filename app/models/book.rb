class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy  # bookが削除されたらそれに紐づくreviewも削除するようにする
  has_many :users, through: :reviews  # booksとusers（多対多)のアソシエーションを定義
  accepts_nested_attributes_for :reviews  # fields_forに必要
  validates :title, presence: true

  def review_rating_percentage
    unless self.reviews.empty?
      reviews.average(:rating).round(1).to_f*100/5
    else
      0
    end
  end

  def self.index_search(keyword)
    if keyword.present?
      Book.where('title LIKE ? OR author LIKE ?', "%#{keyword}%", "%#{keyword}%")
    else
      redirect_to root_path
   end
  end
end


