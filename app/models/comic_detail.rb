class ComicDetail < ApplicationRecord
  belongs_to :comic

  enum story: { hardcover: 0, separate_volumes: 1, single_story: 2 }
  enum purchase_place: { book_store: 0, e_book: 1, others: 2 }
  enum version: { normal_version: 0, special_edition: 1, limited_edition: 2, others: 3 }
  enum comics_size: { paperback_version: 0, shinsho_version: 1, b6_version: 2, a5_version: 3, others: 4 }
end
