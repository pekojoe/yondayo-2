class SearchBooksForm
  
  # ActiveModelとはActiveRecordのDBと連携しない版。
  # 検索キーワードをcontrollerに送りたいだけでDBとは連携させない、と言う今回のケースではこれがgood
  include ActiveModel::Model

  # include ActiveModel::Attributesをしたことでattributeメソッドを使える
  include ActiveModel::Attributes

  attribute :keyword, :string
end