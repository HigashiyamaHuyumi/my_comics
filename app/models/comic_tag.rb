class ComicTag < ApplicationRecord
  belongs_to :comic
  belongs_to :tag
  # タグ付けのバリデーション・アソシエーション
  # validateをいれることで重複を防ぐ
  validates :comic_id, presence: true
  validates :tag_id, presence: true
end
