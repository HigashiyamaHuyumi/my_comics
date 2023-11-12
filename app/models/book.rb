class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :reviews, dependent: :destroy
end
