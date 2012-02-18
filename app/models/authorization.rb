class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: [ :provider, :uid ] }
  validates :provider, presence: true
  validates :uid, presence: true

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.default(User.create_from_hash!(hash))
    Authorization.create(user: user, uid: hash['uid'].to_s, provider: hash['provider'].to_s, email: hash['info']['email'].to_s)
  end
end
