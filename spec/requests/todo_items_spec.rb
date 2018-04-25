require 'rails_helper'

RSpec.describe 'TodoItems API' do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:todo_items) { create_list(:todo_item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { todo_items.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/todo_items' do
    before { get "/todos/#{todo_id}/todo_items", params: {}, headers: headers }

    context 'when todo exists' do
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/todo_items/#{id}", params: {}, headers: headers }

    context 'when todo items exists' do
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'shoudl return the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find TodoItem/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'PUT /todos/:todo_id/todo_items' do
    let(:valid_attributes) { { name: 'Visit Japan', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/todo_items", params: valid_attributes, headers: headers
      end

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      before { post "/todos/#{todo_id}/todo_items", params: {}, headers: headers }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for  PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/todos/#{todo_id}/todo_items/#{id}", params: valid_attributes, headers: headers
    end

    context 'when item exists' do
      it 'should return status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'should update the item' do
        updated_item = TodoItem.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return not found messsage' do
        expect(response.body).to match(/Couldn't find TodoItem/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/todo_items/#{id}", params: {}, headers: headers }

    it 'should return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end