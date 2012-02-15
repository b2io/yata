class User < ActiveRecord::Base
  has_many :authorizations, dependent: :delete_all
  has_many :todos, dependent: :delete_all
  has_many :lists, dependent: :delete_all

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def self.create_from_hash!(hash)
    create! do |user|
      user.name = hash['info']['name'].to_s
      user.email = hash['info']['email'].to_s
    end
  end
end
