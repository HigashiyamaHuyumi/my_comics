class CreateVolumes < ActiveRecord::Migration[6.1]
  def change
    create_table :volumes do |t|
      t.string :name, null: false
      t.belongs_to :comics, null: false, foreign_key: true
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
