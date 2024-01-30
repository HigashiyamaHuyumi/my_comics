class CreateComicTags < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_tags do |t|
      t.references :comic, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
      t.timestamps
    end
    # 同じタグは2回保存出来ない
    add_index :comic_tags, [:comic_id, :tag_id], unique: true
  end
end