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

  belongs_to :bookshelf, dependent: :destroy
  has_many :comic

end
