class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :user_id
      t.integer :comics_detail_id
      t.string :title, null: false
      t.string :author, null: false
      t.integer :isbn_code
      t.string :publisher
      t.datetime :publication_date
      t.string :rakuten_books_url
      t.string :remarks
      t.timestamps
    end
  end
end
