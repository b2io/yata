class Todo < ActiveRecord::Base
  belongs_to :user
  acts_as_list scope: List

  validates :user_id, presence: true
  validates :list_id, presence: true

  def all_for_user
    Todo.find(user_id: current_user.id, order: 'position ASC')
  end
end
