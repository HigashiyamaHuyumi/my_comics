class CreateComicVolumes < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_volumes do |t|
      t.references :comic, foreign_key: true, null: false
      t.references :volume, foreign_key: true, null: false
      t.timestamps
    end
  end
end
