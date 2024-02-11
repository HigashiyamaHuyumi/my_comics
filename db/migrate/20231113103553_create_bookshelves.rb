class CreateBookshelves < ActiveRecord::Migration[6.1]
  def change
    create_table "bookshelves", force: :cascade do |t|
      t.integer :user_id, null: false
      t.string :book_id, null: false
      t.string :title
      t.string :author
      t.string :publisherName
      t.timestamps
    end
  end
end
