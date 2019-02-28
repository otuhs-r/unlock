class Achievement < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
end
