require 'features/features_spec_helper'

feature "Add deadline to Task", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task) { FactoryGirl.create(:task, todo_list_id: todo_list.id) }
  given(:date) { 'Deadline: ' + DateTime.now.to_date.to_s }
  
  background do
    login_as user
    visit '#/home'
    find('.sortarable').hover
    within '.control' do
      find('.glyphicon-time').click
    end
  end

  scenario 'Visitor pick Task deadline successfuly via datepicker' do
    expect(page).to have_css('.ui-datepicker')
    within('.ui-datepicker') do
      find_link(Time.now.day).click
    end

    expect(page).to have_content(date)
  end

  scenario 'Visitor doesn\'t pick deadline via datepicker' do
    find('.glyphicon-time').click
    
    expect(page).not_to have_css('.ui-datepicker')
    expect(page).not_to have_content('Deadline: ')
  end
end 