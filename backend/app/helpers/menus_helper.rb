module MenusHelper
	# def get_menus
	# 	menus = $redis.get('menus')
	# 	if menus.nil?
	# 		menu = Hash.new
	#   		Menu.all.map(&:parent_id).to_set.each do |id|
	#   			menu[id] = Array.new Menu.where(parent_id: id)
	#   		end
	#   		$redis.set('menus',menu.to_json)
	#   		$redis.expire("menus",10.minutes.to_i)
	#   	end
	#   	@menus = JSON.load menu.to_json
	# end
end
