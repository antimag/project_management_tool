class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :todo_status

  validates :title, :description, :due_date, presence: true
  validate :past_due_date, on: :create
  before_validation :set_status_as_new, on: :create
  scope :todo_by_status_id, ->(todo_status_id) {where(todo_status_id: todo_status_id)}

  private
    def past_due_date
      if due_date.present? && due_date < Date.today
        errors.add(:due_date, "can't be in the past")
      end
    end
   def set_status_as_new
     self.todo_status_id = TodoStatus.find_by_name("new").id
   end
end
