require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.create(:comment) }

  it { expect(comment).to belong_to :task }
  it { expect(comment).to have_many(:file_storages).dependent(:destroy) }
end
