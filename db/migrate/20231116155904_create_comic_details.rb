class CreateComicDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_details do |t|
      t.integer :user_id, null: false
      t.integer :volume_id
      t.integer :tag_id
      t.string :story
      t.string :purchase_place
      t.string :version
      t.string :comic_size
      t.timestamps
    end
  end
end
