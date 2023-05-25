require 'rails_helper'

RSpec.describe 'Showing all Foods', type: :feature do
    before(:all) do
    Capybara.reset_sessions!
    end

  before(:each) do
    visit foods_path
    @user = User.create(name: 'Emeka Emmannuel', email: "emekaekeohaa@gmail.com", password:"123456")  
    if page.current_path == new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
    end 
    @first_food = Food.create(user: @user, name: 'Bean Cake', measurement_unit: 'kg', price: 100, quantity: 5)  
  end 

  scenario 'I can see the food name.' do
    visit foods_path
    expect(page).to have_content(@first_food.name)  
  end

  scenario 'I can see the  Add new foood link.' do
    visit foods_path
    expect(page).to have_link("Add Food") 
  end

  scenario 'I can see the Delete link.' do
    visit foods_path
    expect(page).to have_link("Delete") 
  end

  scenario 'I can see the food measurement unit.' do
    visit foods_path
    expect(page).to have_content(@first_food.measurement_unit) 
  end

  scenario 'I can see a food title.' do
    visit foods_path
    expect(page).to have_content(@first_food.name)
  end

end