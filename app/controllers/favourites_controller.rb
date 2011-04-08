# coding: utf-8
class FavouritesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @favourites = @user.favourites
  end

  def show
    @user = User.find(params[:user_id])
    @favourite = @user.favourites.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @favourite = @user.favourites.new
  end

  def create
    @user = User.find(params[:user_id])
    @favourite = @user.favourites.build(params[:favourite])
    if @favourite.save
      redirect_to user_favourites_path(@user)
    else 
      flash[:errors] = @favourite.errors
      render :template => pages_info_path
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @favourite = @user.favourites.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @favourite = @user.favourites.find(params[:id])
    if @favourite.update_attributes(params[:favourite])
      redirect_to user_favourites_path(@user) 
    else  
      flash[:errors] = @favourite.errors
      render :template => pages_info_path
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @favourite = @user.favourite.find(params[:id])
    @favourite.destroy
    redirect_to user_favourites_path(@user)
  end

end
