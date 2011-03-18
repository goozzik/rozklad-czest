# coding: utf-8
class FavouritesController < ApplicationController

  def index
    @favourites = Favourite.all
  end

  def show
    @favourite = Favourite.find(params[:id])
  end

  def new
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new(params[:favourite])
    if @favourite.save
      redirect_to favourites_url
    else 
      flash[:errors] = @favourite.errors
      render :action => pages_errors_path
    end
  end

  def edit
    @favourite = Favourite.find(params[:id])
  end

  def update
    @favourite = Favourite.find(params[:id])
    if @favourite.update_attributes(params[:favourite])
      redirect_to favourites_url 
    else  
      flash[:errors] = @favourite.errors
      render :action => pages_errors_path
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to favourites_url
  end

end
