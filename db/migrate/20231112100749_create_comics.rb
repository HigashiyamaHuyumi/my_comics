class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics, id: false do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.bigint :isbn, null: false, primary_key: true
      t.string :url
      t.string :image_url
      t.string :publisher
      t.datetime :publication_date
      t.string :rakuten_books_url
      t.string :remarks
      t.timestamps
    end
  end
end
