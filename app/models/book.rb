class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy #bookが削除されたらそれに紐づくreviewも削除するようにする
  accepts_nested_attributes_for :reviews # fields_forに必要
  validates :title, presence: true
end
