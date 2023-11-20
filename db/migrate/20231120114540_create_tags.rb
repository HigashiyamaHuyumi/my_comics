class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags, force: :cascade do |t|
      t.string :name
      t.timestamps
    end
  end
end
