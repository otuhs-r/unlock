class AddUnlockDateToBookmark < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :unlock_date, :date
    add_index :bookmarks, :unlock_date
  end
end
