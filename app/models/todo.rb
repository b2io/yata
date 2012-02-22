class Todo < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: :list

  validates :list_id, presence: true
  validates :text, presence: true
end
