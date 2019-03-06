class User < ApplicationRecord
  has_many :bookmarks
  has_many :achievements, through: :bookmarks

  def lock(achievement)
    bookmarks.find_by(achievement_id: achievement.id).locked!
  end

  def unlock(achievement)
    bookmarks.find_by(achievement_id: achievement.id).unlocked!
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end
end
