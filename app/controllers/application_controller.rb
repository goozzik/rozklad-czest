# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :current_user
  before_filter :mobile_device?


  private

    def mobile_device?
      session[:mobile] = true if params[:mobile].to_s == 'true'
      session[:mobile] = false if params[:mobile].to_s == 'false'
      return true unless session[:mobile].nil?
      if request.user_agent =~ /Mobile|webOS|palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile|Opera|opera/
        session[:mobile] = true
      else
        session[:mobile] = false
      end
    end

    def current_user
      session[:user_id] = User.authenticated_with_token(*cookies.signed[:remember_me]).id if cookies.signed[:remember_me]
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
