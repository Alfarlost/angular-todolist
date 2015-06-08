require 'rails_helper'

RSpec.describe FileStoragesController, type: :controller do
  let(:todo_list) { FactoryGirl.create(:todo_list) }
  let(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  let(:comment) { FactoryGirl.create(:comment, task_id: task.id) }
  let!(:file_storage) { FactoryGirl.create(:file_storage, comment_id: comment.id) }

  before do
    create_ability!
  end

  describe 'POST #create' do
    before do
      allow(Comment).to receive(:find).and_return comment
      allow(comment).to receive_message_chain(:file_storages, :build).and_return file_storage
    end

    context 'with passed save' do
      before do
        allow(file_storage).to receive(:save).and_return true
        post :create, format: :json, todo_list_id: todo_list.id, task_id: task.id, comment_id: comment.id, file_name: Faker::Lorem.characters(10)
      end

      it 'assigns @file_storage' do
        expect(assigns(:comment)).to eq comment
      end

      it 'renders file_storage in :json format' do
        expect(response.body).not_to be_empty
      end

      it 'responds with 201 status' do
        expect(response.status).to eq 201
      end
    end

    context 'with failed save' do
      it 'responds with 403 status' do
        allow(file_storage).to receive(:save).and_return false
        post :create, format: :json, todo_list_id: todo_list.id, task_id: task.id, comment_id: comment.id
        expect(response.status).to eq 403
      end
    end
  end
end
