require 'features/features_spec_helper'

feature "Edit Todo List title", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  
  background do
    login_as user
    visit '#/home'
    find('.glyphicon-edit').click
  end

  scenario 'Visitor rename Todo List successfuly' do
    expect(page).to have_field('todolist-change', with: todo_list.title)

    find_field('todolist-change').set('Test title.')

    expect(page).to have_field('todolist-change', with: 'Test title.')

    find('.glyphicon-ok').click

    expect(page).to have_content('Test title.')
  end

  scenario 'Visitor rename Todo List with empty string' do
    find_field('todolist-change').set('')
    find('.glyphicon-ok').click

    expect(page).to have_content(todo_list.title)
  end
end 