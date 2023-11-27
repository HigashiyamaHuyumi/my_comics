class Volume < ApplicationRecord
  validates :voiume, uniqueness: { scope: :user_id, case_sensitive: false }, presence: true

  belongs_to :user
  has_many :comic_volumes
  has_many :comics, through: :comic_volumes

end
