require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { FactoryGirl.create(:task) }

  it { expect(task).to belong_to :todo_list }
  it { expect(task).to have_many(:comments).dependent(:destroy) }
end
