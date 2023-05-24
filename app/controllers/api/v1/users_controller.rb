class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users, status: 200 }
    end
  end

  def show
    if params[:id] == 'sign_out'
      sign_out current_user
      redirect_to new_user_session_path, notice: 'Sign out succesfully' unless @user
    else
      @user = User.find_by(id: params[:id])
      respond_to do |format|
        format.json { render json: @user, status: 200 }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end

  private :user_params
end
