class EstadisticasController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :estadisticas

  def mf_intermensuales_vxa

  end


  private
    def self.permission
      'estadisticas'
    end
end