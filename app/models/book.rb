class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :bookshelves, dependent: :destroy
end
