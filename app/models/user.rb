class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy  # reviewが消えたらそれに紐づくuserも削除
  has_many :books, through: :reviews  # booksとusers（多対多)のアソシエーションを定義

  validates :name, presence: true
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i,
                                message: "は はんかくえいすうじを それぞれ１しゅるいいじょうふくむ 6もじいじょうで にゅうりょくしてください"}
end
