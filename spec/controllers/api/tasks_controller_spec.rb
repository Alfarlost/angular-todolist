require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  let(:todo_list) { FactoryGirl.create(:todo_list) }
  let!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }

  before do
    create_ability!
  end

  describe 'POST #create' do
    before do
      allow(TodoList).to receive(:find).and_return todo_list
      allow(todo_list).to receive_message_chain(:tasks, :build).and_return task
    end

    context 'with passed save' do
      before do
        allow(task).to receive(:save).and_return true
        post :create, format: :json, todo_list_id: todo_list.id, description: task.description
      end

      it 'assigns @task' do
        expect(assigns(:task)).to eq task
      end

      it 'renders task in :json format' do
        expect(response.body).to eq task.to_json(:except => [:created_at, :updated_at], :include => :comments) 
      end

      it 'responds with 201 status' do
        expect(response.status).to eq 201
      end
    end

    context 'with failed save' do
      it 'responds with 403 status' do
        allow(task).to receive(:save).and_return false
        post :create, format: :json, todo_list_id: todo_list.id
        expect(response.status).to eq 403
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow(Task).to receive(:find).and_return task
    end

    context 'with passed update' do
      before do
        allow(task).to receive(:update).and_return true
        patch :update, format: :json, todo_list_id: todo_list.id, id: task.id, description: Faker::Lorem.sentence
      end

      it 'assigns @task' do
        expect(assigns(:task)).to eq task
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
        allow(task).to receive(:update).and_return false
        patch :update, format: :json, todo_list_id: todo_list.id, id: task.id
        expect(response.status).to eq 403
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(Task).to receive(:find).and_return task
    end

    context 'with passed destroy' do
      before do
        allow(task).to receive(:destroy).and_return true
        delete :destroy, format: :json, todo_list_id: todo_list.id, id: task.id
      end

      it 'assigns @task' do
        expect(assigns(:task)).to eq task
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
        allow(task).to receive(:destroy).and_return false
        delete :destroy, format: :json, todo_list_id: todo_list.id, id: task.id
        expect(response.status).to eq 403
      end
    end
  end
end
