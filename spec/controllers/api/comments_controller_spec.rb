require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  let(:todo_list) { FactoryGirl.create(:todo_list) }
  let(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  let!(:comment) { FactoryGirl.create(:comment, task_id: task.id) }

  before do
    create_ability!
  end

  describe 'POST #create' do
    before do
      allow(Task).to receive(:find).and_return task
      allow(task).to receive_message_chain(:comments, :build).and_return comment
    end

    context 'with passed save' do
      before do
        allow(comment).to receive(:save).and_return true
        post :create, format: :json, todo_list_id: todo_list.id, task_id: task.id, body: task.description
      end

      it 'assigns @comment' do
        expect(assigns(:comment)).to eq comment
      end

      it 'renders comment in :json format' do
        expect(response.body).to eq comment.to_json(:except => [:created_at, :updated_at], :include => :file_storages) 
      end

      it 'responds with 201 status' do
        expect(response.status).to eq 201
      end
    end

    context 'with failed save' do
      it 'responds with 403 status' do
        allow(comment).to receive(:save).and_return false
        post :create, format: :json, todo_list_id: todo_list.id, task_id: task.id
        expect(response.status).to eq 403
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(Comment).to receive(:find).and_return comment
    end

    context 'with passed destroy' do
      before do
        allow(comment).to receive(:destroy).and_return true
        delete :destroy, format: :json, todo_list_id: todo_list.id, task_id: task.id, id: comment.id
      end

      it 'assigns @comment' do
        expect(assigns(:comment)).to eq comment
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
        allow(comment).to receive(:destroy).and_return false
        delete :destroy, format: :json, todo_list_id: todo_list.id, task_id: task.id, id: comment.id
        expect(response.status).to eq 403
      end
    end
  end
end
