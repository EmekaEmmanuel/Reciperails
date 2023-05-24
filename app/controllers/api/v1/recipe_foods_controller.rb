class Api::V1::RecipeFoodsController < ApplicationController
  load_and_authorize_resource

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe_id: @recipe.id))
    if @recipe_food.save
      respond_to do |format| 
          format.json { render json: @recipe_food, status: :created }  
        end
    else 
      respond_to do |format| 
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end 
    end  
  end 

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    respond_to do |format| 
      format.json { render json: @recipe_food, status: 200 }  
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      respond_to do |format| 
        format.json { render json: @recipe_food, status: 200 }  
      end
    else
      respond_to do |format| 
        format.json { render json:@recipe_food, status: :unprocessable_entity }  
      end 
    end
    # redirect_to recipe_path(@recipe_food.recipe_id)
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    respond_to do |format| 
      format.json { head :no_content }
    end
    # flash[:success] = 'Recipe Food deleted successfully.'
    # redirect_to recipe_path(@recipe_food.recipe_id)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end

  private :recipe_food_params
end
