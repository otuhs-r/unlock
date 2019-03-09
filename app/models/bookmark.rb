class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :achievement
  validates :user_id, uniqueness: { scope: [:achievement_id] }
  validates :user_id, presence: true
  validates :achievement_id, presence: true

  enum status: { locked: 0, unlocked: 1 }
end
