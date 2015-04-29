class HomeController < ApplicationController

  # before_filter :authenticate_user!
  include HomeHelper
  def index
  	@menus = get_menus
  end
end
