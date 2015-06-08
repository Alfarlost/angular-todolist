require 'rails_helper'

RSpec.describe FileStorage, type: :model do
  let(:file_storage) { FactoryGirl.create(:file_storage) }

  it { expect(file_storage).to belong_to :comment }  
end
