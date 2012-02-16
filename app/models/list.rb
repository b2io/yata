class List < ActiveRecord::Base
  belongs_to :user
  has_many :todos

  validates :user_id, presence: true
end
