class ChecklistItem < ActiveRecord::Base
  belongs_to :todo

  validates :todo_id, presence: true
  validates :text, presence: true

end
