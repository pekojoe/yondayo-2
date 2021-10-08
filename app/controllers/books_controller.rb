class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @book.reviews.build
  end

  def create
    binding.pry
    @book = Book.create(book_params)
    if @book.save
      redirect_to root_path
    else
      render "new"
    end
  end


  private

  def book_params
    params.require(:book).permit(:image, :title, :author, reviews_attributes: [:id, :book_id, :rating, :comment])
  end

end