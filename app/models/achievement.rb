class Achievement < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  accepts_nested_attributes_for :bookmarks
  acts_as_taggable

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
  validates_size_of :tag_list, maximum: 5

  def unlocked_users
    bookmarks.unlocked.map(&:user)
  end
end
