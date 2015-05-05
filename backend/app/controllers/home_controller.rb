class HomeController < ApplicationController
  layout 'layouts/userpanel'
  before_filter :authenticate_user!, :m
  include HomeHelper

  def index
  	# @menus = get_menus
  end

  def showuser 
  	# @menus = get_menus
  	@user = current_user.attributes
  	.slice("email","username","name","roles","last_sign_in_at")
  	render 'user_show'
  end


  def password
    # @menus = get_menus
    render 'password'
  end

  def update_password
    # @menu = get_menus
    if h_params[:password].blank?
      notice = "password is blank"
    elsif h_params[:password_confirmation].blank?
      notice = "password confirmation is blank"
    else
      if h_params[:password] != h_params[:password_confirmation]
        notice = "passwords don't match"
      else
        current_user.update_attributes h_params
        sign_in current_user, bypass: true
        notice = "update success"
      end
    end

    redirect_to users_profile_password_path, notice: notice
  end

  protected 
  	def h_params
  		params.required(:user).permit(:current_password, :password, :password_confirmation)
  	end

    def m
      @menus =  get_menus
    end


end
