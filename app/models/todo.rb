class Todo < ApplicationRecord
  # model association
  has_many :todo_items, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
