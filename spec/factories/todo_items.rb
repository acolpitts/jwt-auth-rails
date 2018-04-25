# spec/factories/todo_items.rb
FactoryBot.define do
  factory :todo_item do
    name { Faker::StarWars.character }
    done false
    todo_id nil
  end
end