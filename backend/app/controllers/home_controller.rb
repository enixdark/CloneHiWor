class HomeController < ApplicationController
  layout 'layouts/userpanel'
  before_filter :authenticate_user!
  
  include HomeHelper

  def index
  	@menus = get_menus
  	@menu = Menuname.all
  end

  def showuser 
  	@menus = get_menus
  	@menu = Menuname.all
  	@user = current_user.attributes
  	.slice("email","username","name","roles","last_sign_in_at")
  	render 'user_show'
  end

  def password
    @menus = get_menus
  	@menu = Menuname.all
  	render 'password'
  end


end
