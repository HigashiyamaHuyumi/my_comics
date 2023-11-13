class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :bookshelves
  has_many :users, through: :bookshelves
end
