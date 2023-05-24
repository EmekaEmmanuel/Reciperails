class Api::V1::ShoppingListController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
  
    def index
      @user = current_user
      @recipe = Recipe.where(user: @user)
      @ingredients = RecipeFood.where(recipe: @recipe).group_by { |ingredient| ingredient.food.name }
      @total_price = @ingredients.map do |_food, ingredients|
        ingredients.map do |ingredient|
          ingredient.food.price * ingredient.quantity
        end.sum
      end.sum

      respond_to do |format|
        format.json { render json: [@user, @recipe, @ingredients, @total_price], status: 200 }
      end
    end
end