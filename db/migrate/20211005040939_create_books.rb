class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :image
      t.string :author
      t.string :google_books_api_id
      t.timestamps
    end
    #add_indexによりデータの読み込み・取得を高速化
    add_index :books, :google_books_api_id, unique: true 
  end
end
