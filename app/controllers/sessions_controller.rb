class SessionsController < ApplicationController
  
  def new
  end

  def create 
    if User.find_by_email(params[:email])
        if User.find_by_email(params[:email]) && User.find_by_email(params[:email]).authenticate(params[:password])
          session[:current_user_id] = User.find_by_email(params[:email]).id
        else
          redirect_to new_session_url, alert: "Authentication failed, please try again."
          return
        end
    else
        if User.from_omniauth(env["omniauth.auth"])
          session[:current_user_id] = User.from_omniauth(env["omniauth.auth"]).id
        else
        redirect_to new_session_url, alert: "Authentication failed, please try again."
        end
    end
    redirect_to root_url, notice: "Successfully Signed In"
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to frustrations_url,
    notice: "Successfully Signed Out"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

end



