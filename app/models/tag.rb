class Tag < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, uniqueness: { scope: :user_id, allow_nil: true }, presence: true
  has_many :comic_tags, dependent: :destroy

  def to_s
    name
  end



end