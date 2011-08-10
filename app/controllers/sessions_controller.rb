#coding: utf-8
class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:user_name], params[:password])
    if user
      session[:user_id] = user.id
      cookies.permanent.signed[:remember_me] = [user.id, user.password_salt] if params[:remember_me] == "true"
      redirect_to root_url
    else
      flash[:error] = "Nieprawidłowe hasło lub login."
      render :template => pages_info_path
    end
  end

  def destroy
    cookies.delete :remember_me
    session[:user_id] = nil
    redirect_to root_url, :notice => "Wylogowano!"
  end

end
