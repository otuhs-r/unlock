class AddComplexIndexToBookmark < ActiveRecord::Migration[5.2]
  def change
    add_index :bookmarks, %i[user_id achievement_id], unique: true
  end
end
