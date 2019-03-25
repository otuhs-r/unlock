class User < ApplicationRecord
  has_many :bookmarks
  has_many :achievements, through: :bookmarks

  def self.find_or_create_from_auth_hash(auth_hash)
    attributes = { provider: auth_hash[:provider],
                   uid: auth_hash[:uid],
                   nickname: auth_hash[:info][:name],
                   image_url: auth_hash[:info][:image] }
    user = User.find_or_create_by(provider: attributes[:provider], uid: attributes[:uid])
    user.update_attributes(attributes) && user
  end
end
