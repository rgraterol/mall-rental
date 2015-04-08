class ArrendatariosController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @arrendatarios = Arrendatario.all
    # if @arrendatarios.blank?
    #   redirect_to new_arrendatario_path
    # end
  end

  def new
    @arrendatario = Arrendatario.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def set_inquilino

    end

    def inquilino_params

    end
end