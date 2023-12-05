class Tag < ApplicationRecord
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }, presence: true
  validate :name_not_blank

  belongs_to :user
  has_many :comic_tags, dependent: :destroy
  has_many :comics, through: :comic_tags

  def to_s
    name
  end

  private

  def name_not_blank
    if name.blank?
      errors.add(:name, "タグ名を入力してください")
    end
  end

end