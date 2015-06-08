require 'features/features_spec_helper'

feature "Delete Task", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  given!(:comment) { FactoryGirl.create(:comment, task_id: task.id) }
  
  background do
    login_as user
    visit '#/home'
  end

  scenario 'Visitor delete Comment successfuly' do
    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-comment').click
    end

    expect(page).to have_content(comment.body)
    
    within '.comment-control' do
      find('.glyphicon-trash').click
    end

    expect(page).not_to have_content(comment.body)
    expect(page).not_to have_css('.comment-control')
  end
end 