class Tag < ApplicationRecord
  has_many :comic_tags, dependent: :destroy

  def to_s
    name
  end
end
