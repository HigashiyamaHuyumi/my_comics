class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics, id: false do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.timestamps
    end
  end
end
