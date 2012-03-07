class ChecklistItem < ActiveRecord::Base
  belongs_to :todo
  acts_as_list

  validates :todo_id, presence: true
  validates :text, presence: true

end
