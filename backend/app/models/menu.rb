class Menu < ActiveRecord::Base
  # belongs_to :user
  after_save :clear_cache
 
  def clear_cache
    $redis.del "menus"
  end
end
