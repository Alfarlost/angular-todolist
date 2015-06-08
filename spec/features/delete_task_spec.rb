require 'features/features_spec_helper'

feature "Delete Task", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  
  background do
    login_as user
    visit '#/home'
  end

  scenario 'Visitor delete Task successfuly' do
    expect(page).to have_content(task.description)

    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-trash').click
    end

    expect(page).not_to have_content(task.description)
    expect(page).not_to have_css('.control')
  end
end 