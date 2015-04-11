class TiendasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tienda, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /tiendas
  # GET /tiendas.json
  def index
    @tiendas = Tienda.all
  end

  # GET /tiendas/1
  # GET /tiendas/1.json
  def show
  end

  # GET /tiendas/new
  def new
    @tienda = Tienda.new
  end

  # GET /tiendas/1/edit
  def edit
  end

  # POST /tiendas
  # POST /tiendas.json
  def create
    @tienda = Tienda.new(tienda_params)

    respond_to do |format|
      if @tienda.save
        format.html { redirect_to @tienda, notice: 'Tienda was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tienda }
      else
        format.html { render action: 'new' }
        format.json { render json: @tienda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiendas/1
  # PATCH/PUT /tiendas/1.json
  def update
    respond_to do |format|
      if @tienda.update(tienda_params)
        format.html { redirect_to @tienda, notice: 'Tienda was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tienda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiendas/1
  # DELETE /tiendas/1.json
  def destroy
    @tienda.destroy
    respond_to do |format|
      format.html { redirect_to tiendas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tienda
      @tienda = Tienda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tienda_params
      params[:tienda]
    end
end
