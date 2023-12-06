class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :bookshelves, foreign_key: 'isbn', primary_key: 'isbn'
end
