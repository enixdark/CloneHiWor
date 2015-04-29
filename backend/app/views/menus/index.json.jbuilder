json.array!(@menus) do |menu|
  json.extract! menu, :id, :name, :user_id, :controllers, :display_order
  json.url menu_url(menu, format: :json)
end
