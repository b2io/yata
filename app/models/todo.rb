class Todo < ActiveRecord::Base
  # TODO: Drop user_id from todo.
  belongs_to :list
  acts_as_list scope: :list

  validates :list_id, presence: true
end
