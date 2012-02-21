class List < ActiveRecord::Base
  belongs_to :user
  has_many :todos
  acts_as_list

  validates :user_id, presence: true
end
