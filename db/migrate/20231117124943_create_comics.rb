class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :user_id, null: false
      t.integer :comic_detail_id
      t.string :title, null: false
      t.string :author, null: false
      t.string :publisher, null: false
      t.string :remarks
      t.timestamps
    end
  end
end
