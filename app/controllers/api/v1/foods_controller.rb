class Api::V1::FoodsController < ApplicationController
  load_and_authorize_resource

  # GET /foods or /foods.json
  def index
    @foods = Food.all
    respond_to do |format|
      format.json { render json: @foods, status: 200 }
    end
  end

  #  GET /foods/1 or /foods/1.json
  def show
    @food = Food.find_by(id: params[:id])
    respond_to do |format| 
      format.json { render json: @food, status: 200 }
    end
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    respond_to do |format|
      if @food.save 
        format.json { render json: @food, status: :created }
      else 
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params) 
        format.json { render json: @food, status: 200 }
      else 
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food.destroy
    respond_to do |format| 
      format.json { head :no_content }
    end
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  private :food_params
end