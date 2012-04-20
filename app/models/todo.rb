class Todo < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: :list
  has_many :checklist_items, dependent: :delete_all

  validates :list_id, presence: true
  validates :text, presence: true
end
