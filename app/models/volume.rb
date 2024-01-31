class Volume < ApplicationRecord
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }, presence: true

  belongs_to :user
  has_many :comic_volumes, dependent: :destroy
  has_many :comics, through: :comic_volumes

  def to_s
    name
  end

end
