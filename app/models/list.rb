class List < ActiveRecord::Base
  belongs_to :user
  has_many :todos

  validates :user_id, presence: true

  def count
    todos.length
  end

  def as_json(options = {})
    super(options.merge(methods: [ :count ]))
  end
end
