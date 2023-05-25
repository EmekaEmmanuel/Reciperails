require 'rails_helper'

RSpec.describe 'Showing a Recipe Details', type: :feature do
  before(:all) do
    Capybara.reset_sessions!
  end

  before(:each) do
    visit foods_path
    @user = User.create(name: 'Emeka Emmannuel', email: 'emekaekeohaa@gmail.com', password: '123456')
    if page.current_path == new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
    @first_food = Food.create(user: @user, name: 'Bean Cake', measurement_unit: 'kg', price: 100, quantity: 5)
    @first_recipe = Recipe.create(user: @user, name: 'meat', description: 'first recipe added to food',
                                  preparation_time: '20min', cooking_time: '30min', public: true)
  end

  scenario 'I can see the recipe name.' do
    visit recipes_path
    click_on @first_recipe.name
    visit recipe_path(@first_recipe.id)
    expect(page).to have_content(@first_recipe.name)
  end

  scenario 'I can see the recipe description.' do
    visit recipes_path
    click_on @first_recipe.name
    visit recipe_path(@first_recipe.id)
    expect(page).to have_content(@first_recipe.description)
  end

  scenario 'I can see the recipe public status.' do
    visit recipes_path
    click_on @first_recipe.name
    visit recipe_path(@first_recipe.id)
    expect(@first_recipe.public).to eq(true)
  end
end
