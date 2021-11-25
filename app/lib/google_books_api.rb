# GoogleBookクラス(場所: app/models/google_book.rb)で使うモジュール↓
module GoogleBooksApi
  
  # GoogleBooksApiのIDからAPIのURLを取得する
  # (既に借りた本か確認するために必要)
  def url_of_creating_from_id(google_books_api_id)
    "https:// www.googleapis.com/books/v1/volumes/#{google_books_api_id}"
  end

  # キーワードから、検索用のURLを取得する
  # (キーワードで登録用の本を検索できるようにするため必要)
  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=40&country=JP"
  end

  # URLから、JSON文字列を取得し、JSONオブジェクトを構築する
  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end

end