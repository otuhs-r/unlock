class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  enum status: { locked: 0, unlocked: 1 }
end
