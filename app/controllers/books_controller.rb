class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    user = current_user
    @books = user.books
  end
  
  def index_search
    @books = Book.index_search(params[:keyword])
    @keyword = params[:keyword]
  end


  def new
    @book = Book.new
    @book.reviews.build
    # googlebooksapi経由で登録する場合は、検索結果をそのままフォームに反映させるようにする
    @book.image = params[:image] if params[:image].present?
    @book.title = params[:title] if params[:title].present?
    @book.author = params[:author] if params[:author].present?
    @book.google_books_api_id = params[:google_books_api_id] if params[:google_books_api_id].present?
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

  def show
    @book = Book.find(params[:id])

    # 詳細ページで表示したい本に紐づく全てのレビューを@reviewsに代入
    @reviews = @book.reviews
    
    # @reviewsのうち、ログイン中のユーザーに紐づくレビューを@reviewに代入
    @review = @reviews.where(params[:user_id] == current_user.id).first
  end

  def edit
    @book = Book.find(params[:id])
    reviews = @book.reviews.where(params[:user_id] == current_user.id).first
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "こうしんしました"
      redirect_to book_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "さくじょしました"
      redirect_to root_path
    end
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