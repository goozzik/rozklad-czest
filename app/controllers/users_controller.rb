# coding: utf-8
class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to pages_info_path, :notice => "Rejestracja przebiegła pomyślnie."
    else
      flash[:errors] = @user.errors
      render :template => pages_info_path
    end
  end

end
