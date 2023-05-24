class Api::V1::RecipesController < ApplicationController
  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.json { render json: @recipes, status: 200 }
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @recipe, status: 200 }
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params) 
        format.json { render json:@recipe, status: :ok}
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
    # redirect_to recipes_url
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  private :recipe_params
end
