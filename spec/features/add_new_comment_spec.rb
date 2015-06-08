require 'features/features_spec_helper'

feature "Add new Comment", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  
  background do
    login_as user
    visit '#/home'
    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-comment').click
    end
  end

  scenario 'Visitor add new Comment successfuly' do
    expect(page).to have_field 'Add new comment!'

    fill_in 'Add new comment!', with: 'Test comment.'

    expect(page).to have_field('Add new comment!', with: 'Test comment.')

    find('.glyphicon-plus').click

    expect(page).to have_css('.comment-control')
    expect(page).to have_content('Test comment.')
  end

  scenario 'Visitor add Comment without body' do
    find('.glyphicon-plus').click

    expect(page).not_to have_css('.comment-control')
  end
end 