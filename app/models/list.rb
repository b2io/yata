class List < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :delete_all
  acts_as_list

  validates :user_id, presence: true
  validates :text, presence: true
end
