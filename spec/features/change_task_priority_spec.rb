require 'features/features_spec_helper'

feature "Change Task priority", js: true do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:todo_list) { FactoryGirl.create(:todo_list, user_id: user.id) }
  given!(:task1) { FactoryGirl.create(:task,  todo_list_id: todo_list.id) }
  given!(:task2) { FactoryGirl.create(:task,  todo_list_id: todo_list.id) }
  given!(:task3) { FactoryGirl.create(:task,  todo_list_id: todo_list.id) }
  given!(:task4) { FactoryGirl.create(:task,  todo_list_id: todo_list.id) }

  
  background do
    login_as user
    visit '#/home'
  end

  scenario 'Visitor change task priority sucessfuly' do
    t1 = all('li')[1]
    t2 =  all('li')[3]
     
    t2.drag_to t1
   
    within all('li')[0] do
      expect(page).to have_content task4.description
    end
    within all('li')[1] do
      expect(page).to have_content task1.description
    end
    within all('li')[2] do
      expect(page).to have_content task3.description
    end
    within all('li')[3] do
      expect(page).to have_content task2.description
    end
  end
end 