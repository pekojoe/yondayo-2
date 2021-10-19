class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews, id: :integer do |t|
      t.integer :user_id, foreign_key: true
      t.integer :book_id, foreign_key: true
      t.integer :rating, null: false, default: 0
      t.string :comment

      t.timestamps
    end
  end
end
