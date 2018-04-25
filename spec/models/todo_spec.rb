# spec/models/todo_spec.rb
require 'rails_helper'

RSpec.describe Todo, type: :model do

  # Association test
  # ensure model has a 1:m relationship with the TodoItem
  it { should have_many(:todo_items).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
