#coding: utf-8
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:user_name], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Zalogowano!"
    else
      flash[:error] = "Nie prawidłowe hasło lub login."
      render :template => pages_info_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Wylogowano!"
  end

end
