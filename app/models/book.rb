class Book < ApplicationRecord
  validates :isbn, presence: true, uniqueness: true, length: { is: 13 }
  has_many :bookshelves, foreign_key: 'isbn'
end
