class User < ActiveRecord::Base
  has_many :todos

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"].to_s, auth["uid"].to_s) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"].to_s
      user.uid = auth["uid"].to_s
      user.name = auth["info"]["name"].to_s
    end
  end
end