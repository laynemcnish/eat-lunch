class MenusController < ApplicationController

  def create
    name = params[:name]
    postal_code = params[:postal_code]

    menu_data = MenuService.new.get_menu_for_restaurant(name, postal_code)

    render json: menu_data
  end

end