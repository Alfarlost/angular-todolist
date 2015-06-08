require 'features/features_spec_helper'

feature "Add new Todo List", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  
  background do
    login_as user
    visit '#/home'
    find('.addlist').click
  end

  scenario 'Visitor add new Todo List successfuly' do
    find_field('todolist-change').set('Test title.')

    expect(page).to have_field('todolist-change', with: 'Test title.')

    find('.glyphicon-ok').click

    expect(page).to have_content('Test title.')
  end

  scenario 'Visitor add Todo List without title' do
    find('.glyphicon-ok').click

    expect(page).to have_content('New Todo List')
  end
end 