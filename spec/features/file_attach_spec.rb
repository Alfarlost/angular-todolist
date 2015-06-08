require 'features/features_spec_helper'

feature "Attach File to Comment", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  given!(:comment) { FactoryGirl.create(:comment, task_id: task.id) }
  
  background do
    Capybara.current_driver = :selenium
    login_as user
    visit '#/home'
    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-comment').click
    end
    find('.glyphicon-paperclip').click

    expect(page).to have_button 'upload'
  end

  scenario 'Visitor attach new File to Comment successfuly' do
    attach_file('Attach File', File.expand_path('spec/test_files/testfile_1MB'))

    click_button('upload')

    expect(page).to have_link('testfile_1MB,')
  end

  scenario 'Visitor attach File too big to Comment' do
    attach_file('Attach File', File.expand_path('spec/test_files/testfile_25MB'))

    click_button('upload')

    expect(page).not_to have_link('testfile_25MB,')
    expect(page).to have_content('Can\'t upload. File size too big, should be less then 24MB!')
  end
end 