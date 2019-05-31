class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.string :title, null: false, index: true, unique: true

      t.timestamps
    end
  end
end
