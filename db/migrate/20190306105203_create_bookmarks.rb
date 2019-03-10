class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :achievement, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
