require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@u = User.new
  end 

  test "create new user" do
  	@u.password = '12345678'
  	@u.username = 'admin'
  	@u.email = 'admin@gmail.com'
  	@u.name = 'admin'
  	@u.save
  end
end
