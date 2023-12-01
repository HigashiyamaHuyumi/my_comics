class User < ApplicationRecord
  validates :nickname, presence: true
  validates :email, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookshelves, dependent: :destroy
  has_many :comics
  has_many :tags
  has_many :volumes

end
