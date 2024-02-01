class Bookshelf < ApplicationRecord
  self.primary_key = "isbn"
  belongs_to :user
  belongs_to :book
end
