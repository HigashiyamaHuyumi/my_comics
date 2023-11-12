class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :user_id, null: false
      t.integer :comics_detail_id, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.integer :isbn_code, null: false
      t.string :publisher, null: false
      t.datetime :publication_date, nill: false
      t.string :rakuten_books_url, null: false
      t.string :remarks, null: false
      t.timestamps
    end
  end
end
