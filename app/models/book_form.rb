class BookForm
  include ActiveModel::Model
 
  attr_accessor :image, :title, :author, :rating, :comment
  validates :title, presence: true
  validates :rating, presence: true
 
  def save
    Book.create(image: image, title: title, author: author)
    Review.create(rating: rating, comment: comment)
  end
end