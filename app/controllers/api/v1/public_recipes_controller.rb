class Api::V1::PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).includes(:user).order('created_at DESC')
    @ingredients = RecipeFood.all
  end
end
