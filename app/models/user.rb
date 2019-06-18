class User < ApplicationRecord
  has_many :bookmarks
  has_many :achievements, through: :bookmarks

  def self.find_or_create_from_auth_hash(auth_hash)
    attributes = { provider: auth_hash[:provider],
                   uid: auth_hash[:uid],
                   nickname: auth_hash[:info][:name],
                   image_url: auth_hash[:extra][:raw_info][:profile_image_url_https] }
    user = User.find_or_create_by(provider: attributes[:provider], uid: attributes[:uid])
    user.update_attributes(attributes) && user
  end

  def unlocked_bookmarks
    bookmarks.unlocked
  end

  def locked_bookmarks
    bookmarks.locked
  end
end
