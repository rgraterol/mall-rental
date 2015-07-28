module Dynamic
  class DynamicFilterLocalsController < ApplicationController
    respond_to :json

    def actualizar

      @ubicacion = params[:ubicacion]
      @tipo =  params[:tipo]
      @estado = params[:estado]

      @locals = Local.where('mall_id = ?', current_user.mall_id)

      if @ubicacion != ''
        @locals = @locals.where("nivel_mall_id= ?", @ubicacion)
      end

      if @tipo != ''
        @locals = @locals.where(" tipo_local_id= ?", @tipo)
      end

      if @estado != ''
        if @estado == 'Disponible'
          @estad_num = 0
        elsif @estado == 'Alquilado'
          @estad_num = 1
        elsif @estado == 'En_Reparacion'
          @estad_num = 2
        elsif @estado == 'Vendido'
          @estad_num = 3
        end
        @locals = @locals.where(" tipo_estado_local= ?", @estad_num)
      end

      if @ubicacion == '' or @tipo == '' or @estado == ''

      end

      if  @locals.length > 0
        render partial: 'locals/table_filter_locals'
      else
        render partial: 'locals/table_filter_locals_nil'
      end

    end
  end
end
