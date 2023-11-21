class CreateComicTags < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_tags do |t|
      t.references :comic, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
      t.timestamps
    end
  end
end
