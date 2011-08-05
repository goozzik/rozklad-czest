# coding: utf-8
class FavouritesController < ApplicationController

  before_filter do
    logged_in? && authorize?
  end

  def logged_in?
    defined?(session[:user_id])
  end

  def authorize?
    redirect_to root_path unless params[:user_id].to_i == session[:user_id]
  end

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
