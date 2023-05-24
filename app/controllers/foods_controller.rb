class FoodsController < ApplicationController
  load_and_authorize_resource

  # before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @foods = Food.all
    respond_to do |format|
      format.html
      format.json { render json: @foods, status: 200 }
    end
  end

  #  GET /foods/1 or /foods/1.json
  def show
    @food = Food.find_by(id: params[:id])
    respond_to do |format|
      format.html { redirect_to foods_path, notice: 'Food found' unless @user }
      format.json { render json: @user, status: 200 }
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
        format.html { redirect_to root_path, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully deled.' }
      format.json { head :no_content }
    end
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  private :food_params
end



# Use callbacks to share common setup or constraints between actions.
# def set_food
#   @food = Food.find(params[:id])
# end


# DELETE /foods/1 or /foods/1.json
# def destroy
#   @food.destroy

#   respond_to do |format|
#     format.html { redirect_to foods_url, notice: "Food was successfully destroyed." }
#     format.json { head :no_content }
#   end
# end


# PATCH/PUT /foods/1 or /foods/1.json
# def update
#   respond_to do |format|
#     if @food.update(food_params)
#       format.html { redirect_to food_url(@food), notice: "Food was successfully updated." }
#       format.json { render :show, status: :ok, location: @food }
#     else
#       format.html { render :edit, status: :unprocessable_entity }
#       format.json { render json: @food.errors, status: :unprocessable_entity }
#     end
#   end
# end



# POST /foods or /foods.json
# def create
#   @food = Food.new(food_params)
#   respond_to do |format|
#     if @food.save
#       format.html { redirect_to food_url(@food), notice: "Food was successfully created." }
#       format.json { render :show, status: :created, location: @food }
#     else
#       format.html { render :new, status: :unprocessable_entity }
#       format.json { render json: @food.errors, status: :unprocessable_entity }
#     end
#   end
# end
