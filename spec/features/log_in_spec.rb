require 'features/features_spec_helper'
include OauthStub

feature "Log In", js: true do 
  given!(:user) { FactoryGirl.create(:user) }

  background do
    visit '#/log_in'
  end

  context "Visitior login successfuly" do
    after do
      expect(page).not_to have_content 'Log in'
      expect(page).to have_content user.email
      expect(page).to have_content 'Sign out'
    end

    scenario 'via sign in form' do
        fill_in 'Your email', with: user.email
        fill_in 'Password', with: user.password
  
        click_button 'Log in'
    end

    scenario 'via facebook' do
      set_omniauth
      click_link 'Facebook'
    end
  end

  scenario 'Visitor login with wrong data' do
      fill_in 'Your email', with: Faker::Internet.email
      fill_in 'Password', with: Faker::Internet.password

      click_button 'Log in'
    
    expect(page).not_to have_content 'Sign out'
    expect(page).to have_content 'Log in'
    expect(page).not_to have_content user.email
    expect(page).to have_content 'You entered wrong data. Invalid email or password.'
  end

  scenario 'Visitor click Sign Up link' do
      click_link 'Sign Up'

    expect(page).to have_content 'Sign Up'
    expect(page).not_to have_link 'Sign Up'
    expect(page).to have_link 'Log In'
    expect(page).to have_content 'Already have an account?' 
  end
end