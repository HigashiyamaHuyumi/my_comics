class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.string :publisherName, null: false
      t.integer :story
      t.integer :purchase_place
      t.integer :comics_size
      t.string :remarks
      t.timestamps
    end
  end
end