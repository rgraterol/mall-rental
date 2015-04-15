module Dynamic
  class DynamicAddActividadController < ApplicationController
    respond_to :json
    def actividad
      @actividad_economica = ActividadEconomica.new(nombre: params[:nombre])
      if @actividad_economica.save
        respond_with(@actividad_economica)
      else
        respond_with(@actividad_economica)
      end
    end
  end
end