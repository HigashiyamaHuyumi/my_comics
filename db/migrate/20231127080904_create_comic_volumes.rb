class CreateComicVolumes < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_volumes do |t|
      t.integer :comics_id, foreign_key: true, null: false
      t.integer :volume_id, foreign_key: true, null: false
      t.timestamps
    end
  end
end