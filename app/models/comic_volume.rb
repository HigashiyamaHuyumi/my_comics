class ComicVolume < ApplicationRecord
  belongs_to :comic
  belongs_to :volume

  validates :comic_id, presence: true
  validates :volume_id, presence: true
end
