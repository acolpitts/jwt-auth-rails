# db/seeds.rb
# seed 50 records
50.times do
  todo = Todo.create(title: Faker::Lorem.word, created_by: User.first.id)
  todo.todo_items.create(name: Faker::Lorem.word, done: false)
end