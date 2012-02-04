class User < ActiveRecord::Base
  has_many :authorizations
  has_many :todos

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def self.create_from_hash!(hash)
    create! do |user|
      user.name = hash['info']['name'].to_s
      user.email = hash['info']['email'].to_s
    end
  end
end
