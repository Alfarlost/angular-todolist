require 'features/features_spec_helper'

feature "Add new Task", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  
  background do
    login_as user
    visit '#/home'
  end

  scenario 'Visitor add new Task successfuly' do
    fill_in 'Start typing here to create task...', with: 'Test description.'

    expect(page).to have_field('Start typing here to create task...', with: 'Test description.')

    find('.btn-add').click

    expect(page).to have_css('.check')
    expect(page).to have_content('Test description.')
  end

  scenario 'Visitor add Task without description' do
    find('.btn-add').click

    expect(page).not_to have_css('.check')
    expect(page).not_to have_css('.control')
    expect(page).not_to have_css('.body')
  end
end 