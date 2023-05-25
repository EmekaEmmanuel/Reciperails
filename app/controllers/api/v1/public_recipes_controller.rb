class Api::V1::PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).includes(:user).order('created_at DESC')
    @ingredients = RecipeFood.all
    respond_to do |format|
      format.json { render json: [@recipes, @ingredients], status: 200 }
    end
  end
end
