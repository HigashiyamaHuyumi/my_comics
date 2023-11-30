class Comic < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :publisherName, presence: true
  
  enum story: { hardcover: 0, separate_volumes: 1, single_story: 2 }
  enum purchase_place: { book_store: 0, e_book: 1, others: 2 }

  belongs_to :user

  has_many :comic_volumes, dependent: :destroy
  has_many :volumes, through: :comic_volumes

  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags

  attr_accessor :new_tag

  # タグ付けの新規投稿用メソッド
  def save_tags(tag_params)
    self.tags = tag_params.split(',') if tag_params.present?
  end

  # タグ付けの更新用メソッド
  def update_tags(latest_tags)
    return unless latest_tags.present?

    # 既存のタグも更新対象のタグもある場合は差分更新
    current_tags = self.tags.pluck(:name)
    old_tags = current_tags - Array(latest_tags)
    new_tags = Array(latest_tags) - current_tags

    old_tags.each do |old_tag|
      tag = self.tags.find_by(name: old_tag)
      self.tags.delete(tag) if tag.present?
    end

    new_tags.each do |new_tag|
      Tag.find_or_create_by(name: new_tag)
    end
  end

   # 巻数の新規投稿用メソッド
  def save_volumes(volume_params)
    self.volumes = volume_params.split(',') if volume_params.present?
  end

    # 巻数の更新用メソッド
  def update_volumes(latest_volumes)
    return unless latest_volumes.present?
  
    # 既存の巻数も更新対象の巻数もある場合は差分更新
    current_volumes = self.volumes.pluck(:name)
    old_volumes = current_volumes - Array(latest_volumes)
    new_volumes = Array(latest_volumes) - current_volumes
  
    old_volumes.each do |old_volume|
      volume = self.volumes.find_by(name: old_volume)
      self.volumes.delete(volume) if volume.present?
    end
  
    new_volumes.each do |new_volume|
      Volume.find_or_create_by(name: new_volume)
    end
  end
  
  # タイトルごとの巻数合計
  def total_volumes
    volumes.length
  end
  
  def self.search(query)
    where(
      "title LIKE ? OR author LIKE ? OR publisherName LIKE ? OR story LIKE ? OR purchase_place LIKE ? OR purchase_place_custom LIKE ? OR tags.name LIKE ? OR remarks LIKE ?",
      "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
    ).joins("LEFT JOIN comic_tags ON comics.id = comic_tags.comic_id")
     .joins("LEFT JOIN tags ON tags.id = comic_tags.tag_id")
  end
  
end