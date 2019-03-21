class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :achievement
  validates :achievement_id, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true
  validates :achievement_id, presence: true

  enum status: { locked: 0, unlocked: 1 }

  def reverse
    locked? ? unlocked! : locked!
    self
  end

  def unlock_date
    self[:unlock_date] if unlocked?
  end
end
