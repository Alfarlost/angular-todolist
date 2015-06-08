require 'features/features_spec_helper'
include OauthStub

feature "Registartion", js: true do 

  background do
    visit '#/log_in'
    click_link 'Sign Up'
  end

  context "Visitior register successfuly" do
    after do
      expect(page).not_to have_content 'Log In'
      expect(page).not_to have_content 'Sign Up'
      expect(page).to have_content 'test@test.com'
      expect(page).to have_content 'Sign out'
    end

    scenario 'via sign up form' do
      password = Faker::Internet.password
        fill_in 'Your email', with: 'test@test.com'
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
  
        click_button 'Sign Up'
    end

    scenario 'via facebook' do
      set_omniauth({ :info => { :email => 'test@test.com' } })
      click_link 'Facebook'
    end
  end

  context 'Visitor registers with' do
    given(:existed_user) { FactoryGirl.create(:user) }

    after do
      expect(page).not_to have_content 'Sign out'
      expect(page).to have_content 'Sign Up'
      expect(page).not_to have_content existed_user.email
    end

    scenario 'email that already exists' do 
        fill_in 'Your email', with: existed_user.email
        fill_in 'Password', with: existed_user.password
        fill_in 'Password confirmation', with: existed_user.password

        click_button 'Sign Up'
    
      expect(page).to have_content 'User with such email already exists!'
    end

    scenario 'too short password' do
      short_password = Faker::Internet.password(3)
        fill_in 'Your email', with: Faker::Internet.email
        fill_in 'Password', with: short_password
        fill_in 'Password confirmation', with: short_password

        click_button 'Sign Up'
    
      expect(page).to have_content 'Password too short. Must be at least 8 symbols.'
    end

    scenario 'and password confirmation doesn\' t match password' do 
        fill_in 'Your email', with: Faker::Internet.email
        fill_in 'Password', with: Faker::Internet.password
        fill_in 'Password confirmation', with: Faker::Internet.password

        click_button 'Sign Up'
    
      expect(page).to have_content 'Password confirmation doesn\'t match password.'
    end
  end

  scenario 'Visitor click Log In link' do
      click_link 'Log In'

    expect(page).to have_content 'Log in'
    expect(page).not_to have_link 'Log In'
    expect(page).to have_link 'Sign Up'
    expect(page).to have_content 'Don\'t have an account?' 
  end
end