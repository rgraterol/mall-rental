module Dynamic
  class DynamicAddNivelMallController < ApplicationController
    respond_to :json
    def guardar
      @nivel_mall = NivelMall.new(nombre: params[:nombre], mall_id: current_user.mall.id)
      if @nivel_mall.save
        respond_with(@nivel_mall)
      else
        respond_with(@nivel_mall)
      end
    end
  end
end