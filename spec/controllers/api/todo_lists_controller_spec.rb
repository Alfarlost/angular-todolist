require 'rails_helper'

RSpec.describe Api::TodoListsController, type: :controller do
  let(:todo_list) { FactoryGirl.create(:todo_list) }
  let!(:todo_lists) { FactoryGirl.create_list(:todo_list, 2) }

  before do
    create_ability!
  end

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it 'assigns @todo_lists' do
      expect(assigns(:todo_lists)).to eq todo_lists
    end

    it 'renders todo_lists in :json format' do
      expect(response.body).to eq todo_lists.to_json(:except => [:created_at, :updated_at], :include => :tasks) 
    end

    it 'responds with success status' do
      expect(response.status).to eq 200
    end
  end
  
  describe 'POST #create' do
    before do
      allow(TodoList).to receive(:new).and_return todo_list
    end

    context 'with passed save' do
      before do
        allow(todo_list).to receive(:save).and_return true
        post :create, format: :json
      end

      it 'assigns @todo_list' do
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'renders todo_lists in :json format' do
        expect(response.body).to eq todo_list.to_json(:except => [:created_at, :updated_at], :include => :tasks) 
      end

      it 'responds with 201 status' do
        expect(response.status).to eq 201
      end
    end

    context 'with failed save' do
      it 'responds with 403 status' do
        allow(todo_list).to receive(:save).and_return false
        post :create, format: :json
        expect(response.status).to eq 403
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow(TodoList).to receive(:find).and_return todo_list
    end

    context 'with passed update' do
      before do
        allow(todo_list).to receive(:update).and_return true
        patch :update, format: :json, id: todo_list.id, title: Faker::Lorem.characters(10)
      end

      it 'assigns @todo_list' do
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'renders nothing' do
        expect(response.body).to be_empty 
      end

      it 'responds with 204 status' do
        expect(response.status).to eq 204
      end
    end

    context 'with failed update' do
      it 'responds with 403 status' do
        allow(todo_list).to receive(:update).and_return false
        patch :update, format: :json, id: todo_list.id
        expect(response.status).to eq 403
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(TodoList).to receive(:find).and_return todo_list
    end

    context 'with passed destroy' do
      before do
        allow(todo_list).to receive(:destroy).and_return true
        delete :destroy, format: :json, id: todo_list.id
      end

      it 'assigns @todo_list' do
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'renders nothing' do
        expect(response.body).to be_empty 
      end

      it 'responds with 204 status' do
        expect(response.status).to eq 204
      end
    end

    context 'with failed destroy' do
      it 'responds with 403 status' do
        allow(todo_list).to receive(:destroy).and_return false
        delete :destroy, format: :json, id: todo_list.id
        expect(response.status).to eq 403
      end
    end
  end
end
