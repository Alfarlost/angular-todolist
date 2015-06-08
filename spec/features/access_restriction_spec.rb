require 'features/features_spec_helper'

  feature "Access restriction", js: true do 
    scenario 'User visits home page without sign in' do
      visit '#/home'

      expect(page).to have_content 'Log in'
      expect(page).not_to have_link 'Log In'
      expect(page).to have_link 'Sign Up'
      expect(page).to have_content 'Don\'t have an account?'
      expect(page).not_to have_content 'SIMPLE TODO LISTS'
    end
  end 