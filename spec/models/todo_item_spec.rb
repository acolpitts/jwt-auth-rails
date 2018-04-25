# spec/models/todo_item_spec.rb
require 'rails_helper'

# Test suite for the TodoItem model
RSpec.describe TodoItem, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:todo) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
