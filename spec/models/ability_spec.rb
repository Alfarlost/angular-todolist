require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe 'User' do
    describe 'abilities' do
      let(:user) { FactoryGirl.create(:user) }
      let(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
      let(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
      let(:comment) { FactoryGirl.create(:comment, task_id: task.id) }
      let(:file_storage) { FactoryGirl.create(:file_storage, comment_id: comment.id) }
      subject(:ability) { Ability.new(user) }

      context 'when data belongs to user' do
        it { expect(ability).to be_able_to(:manage, todo_list) }
        it { expect(ability).to be_able_to(:manage, task) }
        it { expect(ability).to be_able_to(:manage, comment) }
        it { expect(ability).to be_able_to(:manage, file_storage) }
      end
      
      context 'when data belongs to another user' do
        let(:new_user) { FactoryGirl.create(:user) }
        subject(:ability) { Ability.new(new_user) }

        it { expect(ability).not_to be_able_to(:manage, todo_list) }
        it { expect(ability).not_to be_able_to(:manage, task) }
        it { expect(ability).not_to be_able_to(:manage, comment) }
        it { expect(ability).not_to be_able_to(:manage, file_storage) }
      end
    end
  end      
end
