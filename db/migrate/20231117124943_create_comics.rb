class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :initial
      t.string :author
      t.string :publisherName
      t.integer :situation
      t.integer :story
      t.integer :medium
      t.string :purchase_place_custom
      t.string :comic_size
      t.string :remarks
      t.timestamps
    end
  end
end