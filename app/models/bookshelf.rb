class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :comics
end
