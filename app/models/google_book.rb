class GoogleBook
  # クラスにモジュール(ActiveModel::Model)をincludeすると、
  # そのクラスのインスタンスはActiveRecordを継承したクラスのインスタンスと同様に
  # form_with や render などのヘルパーメソッドの引数として扱え、
  # バリデーションの機能を使用できるようになる。つまりほぼActiveRecordのDBなし版。
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  # 以下ActiveModel::Attributesをincludeしたのでattributeが使える
  attribute :image, :string
  attribute :title, :string
  attribute :author, :string
  attribute :google_books_api_id, :string

  validates :title, presence: true

  #クラスメソッドを定義。都度のself.を書かなくてOK
  class << self
    #GoogleBookクラスにGoogleBooksApiモジュールのメソッドがインスタンスメソッドとして組み込まれる
    #モジュールの場所:app/lib/google_books_api.rb
    include GoogleBooksApi
    
    #1つのitemから1つのインスタンスを生成する
    def new_from_item(item)
      @item = item
      @volume_info = @item['volumeInfo']
      new(
        image: image_url, #プライベートメソッドに記載.@volume_info['imageLinks']['smallThumnail']が存在する場合は取得
        title: @volume_info['title'],
        
        # &.→レシーバ(@volume_info['authors'])がnilのときはnilを返してくれる演算子
        author: @volume_info['authors']&.join(','),
        google_books_api_id: @item['id']
      )
    end

    # google_books_api_idから1つの本の情報(item)をJSONとして取得する
    def new_from_id(google_books_api_id)
      url = url_of_creating_from_id(google_books_api_id) #モジュールのメソッド
      item = get_json_from_url(url)
      new_from_item(item)
    end

    # 検索結果をインスタンス群として返すクラスメソッド
    def search(keyword)
      # モジュールのメソッド。キーワードから、検索用のURLを取得
      url = url_of_searching_from_keyword(keyword) 

      # モジュールのメソッド。URLから、JSON文字列を取得し、JSONオブジェクトを構築する
      json = get_json_from_url(url)

      # JSONオブジェクトから、複数のitemsを配列で取得
      items = json['items']

      return [] unless items #itemsがない場合は空の配列を返す

      # 検索結果群(items)の要素について、順にインスタンスを生成
      items.map do |item| #mapメソッド:各要素へ順に処理を実行してくれるメソッド. eachと似ている
        GoogleBook.new_from_item(item)
      end
    end


    private
    # @volume_info['imageLinks']が存在する場合、その['smallThumnail']を取得する
    def image_url
      @volume_info['imageLinks']['smallThumbnail'] if @volume_info['imageLinks'].present?
    end
  end
end