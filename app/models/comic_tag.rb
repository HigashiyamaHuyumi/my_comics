class ComicTag < ApplicationRecord
  belongs_to :comic
  belongs_to :tag

  validates :comic_id, presence: true
  validates :tag_id, presence: true
end
