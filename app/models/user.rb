class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
    end
  end

  has_many :bookshelves, dependent: :destroy
  has_many :comics
  has_many :tags
  
  def total_hardcover_volumes
    comics.paper.sum(&:hardcover_volumes_count)
  end
  
end