class Tag < ApplicationRecord
  belongs_to :user  # Userモデルとの関連付けを追加
  validates :name, presence: true
  has_many :comic_tags, dependent: :destroy

  def to_s
    name
  end

  

end