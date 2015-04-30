class Menu < ActiveRecord::Base
  after_save :clear_cache
 
  def clear_cache
    $redis.del "menus"
  end
end
