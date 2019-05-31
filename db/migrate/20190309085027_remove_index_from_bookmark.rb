class RemoveIndexFromBookmark < ActiveRecord::Migration[5.2]
  def change
    remove_index :bookmarks, :user_id
    remove_index :bookmarks, :achievement_id
  end
end
