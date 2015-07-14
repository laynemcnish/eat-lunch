class MenusController < ApplicationController

  def get_menu
    name = params[:name]
    postal_code = params[:postal_code]

    service_response = MenuService.new.get_menu_for_restaurant(name, postal_code)

    if service_response.success
      render json: service_response.entity
    else
      render json: service_response.errors
    end
  end

end