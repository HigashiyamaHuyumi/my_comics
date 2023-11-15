class CreateBookshelves < ActiveRecord::Migration[6.1]
  def change
    create_table :bookshelves do |t|
      t.integer :user_id, null: false
      t.integer :comics_id
      t.integer :book_id
      t.string :title
      t.string :author
      t.timestamps
    end
  end
end
