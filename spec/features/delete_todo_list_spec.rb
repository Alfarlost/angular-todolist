require 'features/features_spec_helper'

feature "Delete Todo List", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  
  background do
    login_as user
    visit '#/home'
  end

  scenario 'Visitor delete Todo List successfuly' do
    find('.glyphicon-trash').click

    expect(page).not_to have_content(todo_list.title)
    expect(page).not_to have_css('.nav-bar-blue')
    expect(page).to have_css('.addlist')
  end
end 