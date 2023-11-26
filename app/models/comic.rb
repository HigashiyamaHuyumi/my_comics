class Comic < ApplicationRecord
  enum story: { hardcover: 0, separate_volumes: 1, single_story: 2 }
  enum purchase_place: { book_store: 0, e_book: 1, others: 2 }
  enum comics_size: { paperback_version: 0, shinsho_version: 1, b6_version: 2, a5_version: 3, others: 4 }
  
  belongs_to :user

  # タグ付けのアソシエーション
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

end