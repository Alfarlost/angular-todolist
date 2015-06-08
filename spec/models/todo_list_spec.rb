require 'rails_helper'

RSpec.describe TodoList, type: :model do
  let(:todo_list) { FactoryGirl.create(:todo_list) }

  it { expect(todo_list).to belong_to :user }
  it { expect(todo_list).to have_many(:tasks).dependent(:destroy) }
end
