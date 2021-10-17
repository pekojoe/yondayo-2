class BooksController < ApplicationController
  before_action :authenticate_user!, expect: :index
  
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @book.reviews.build
  end

  def create
    @book = Book.create(book_params)
    if @book.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def search
    #検索フォームに入力されたキーワードから、検索キーワードのインスタンス作成
    @search_form = SearchBooksForm.new(search_books_params) 
    # 受け取った検索キーワードをGooglebookクラスのsearchメソッドに渡して、検索結果群（インスタンス群）の配列として受け取る
    @books = GoogleBook.search(@search_form.keyword)
  end


  private

  def book_params
    params.require(:book).permit(:image, :title, :author, reviews_attributes: [:id, :user_id, :book_id, :rating, :comment])
  end

  # google_bookモデルが検索を行う際、keywordを受け取ることを許可
  def search_books_params
    params.permit(:keyword)
  end

end