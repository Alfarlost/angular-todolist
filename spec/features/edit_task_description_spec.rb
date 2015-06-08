require 'features/features_spec_helper'

feature "Edit Task description", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  
  background do
    login_as user
    visit '#/home'
    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-edit').click
    end
  end

  scenario 'Visitor rename Task successfuly' do
    expect(page).to have_field('task-change', with: task.description)

    find_field('task-change').set('Test description.')

    expect(page).to have_field('task-change', with: 'Test description.')

    find('.glyphicon-ok').click

    expect(page).to have_content('Test description.')
  end

  scenario 'Visitor rename Task with empty string' do
    find_field('task-change').set('')
    find('.glyphicon-ok').click

    expect(page).to have_content(task.description)
  end
end 