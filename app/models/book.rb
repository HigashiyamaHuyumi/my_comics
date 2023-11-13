class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :user
  has_many :bookshelf
end
