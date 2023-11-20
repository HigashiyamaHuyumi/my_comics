class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags, id: false do |t|
      t.references :comic, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
