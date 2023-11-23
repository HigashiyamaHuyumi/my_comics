class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookshelves
  has_many :books, through: :bookshelves
  
   # bookshelf_books メソッドを追加
  def bookshelf_books
    Book.where(id: bookshelves.pluck(:book_id))
  end
  
  has_many :comics
  has_many :tags

end
