class ComicTag < ApplicationRecord
  belongs_to :comic
  belongs_to :tag
  # タグ付けのバリデーション・アソシエーション
  # validateをいれることで重複を防ぐ
  validates :comic_id, uniqueness: { scope: :tag_id }
  validates :tag_id, presence: true
end
