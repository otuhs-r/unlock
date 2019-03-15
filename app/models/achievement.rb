class Achievement < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks
  accepts_nested_attributes_for :bookmarks
  acts_as_taggable

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
end
