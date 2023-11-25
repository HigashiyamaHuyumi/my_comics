class Tag < ApplicationRecord
  validates :name, uniqueness: { scope: :user_id, allow_nil: true }, presence: true
  
  belongs_to :user
  has_many :comic_tags, dependent: :destroy

  def to_s
    name
  end

end