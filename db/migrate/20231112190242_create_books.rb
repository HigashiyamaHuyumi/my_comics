class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.string :title
      t.string :author
      t.string :publisherName
      t.string :isbn, null: false, primary_key: true
      t.string :url
      t.string :image_url
      t.string :salesDate
      t.timestamps
    end
  end
end
