require 'rails_helper'
include OauthStub

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }

  it { expect(user).to have_many(:todo_lists).dependent(:destroy) }

  context '.from_omniauth' do
    it 'returns user' do
      expect(User.from_omniauth(set_omniauth(uid: '1222'))).to be_instance_of(User)
    end

    it 'creates new user' do
      expect(User.from_omniauth(set_omniauth(uid: '1222'))).not_to eq user
    end

    it 'takes existed user' do
      expect(User.from_omniauth(set_omniauth)).to eq user
    end
  end
end
