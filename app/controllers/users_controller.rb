class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to frustrations_url, notice: "Welcome!"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).
      permit(:email, :password, :password_confirmation, :name, :avatar, :town)
  end
end
