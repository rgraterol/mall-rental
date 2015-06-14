class NivelMallsController < ApplicationController
  before_action :set_nivel_mall, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  before_action :check_user_mall

  # GET /nivel_malls
  # GET /nivel_malls.json
  def index
    @mall = Mall.find(params[:mall_id])
    @nivel_malls = NivelMall.where(mall_id: params[:mall_id])
  end

  # GET /nivel_malls/1
  # GET /nivel_malls/1.json
  def show
  end

  # GET /nivel_malls/new
  def new
    @mall = Mall.find(params[:mall_id])
    @nivel_mall = NivelMall.new
  end

  # GET /nivel_malls/1/edit
  def edit
  end

  # POST /nivel_malls
  # POST /nivel_malls.json
  def create
    @nivel_mall = NivelMall.new(nivel_mall_params)

    respond_to do |format|
      if @nivel_mall.save
        format.html { redirect_to nivel_malls_index_path(nivel_mall_params[:mall_id]), notice: 'Nivel mall fue creado exitosamente.' }
        format.json { render :index, status: :created, location: @nivel_mall }
      else
        format.html { render :new }
        format.json { render json: @nivel_mall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nivel_malls/1
  # PATCH/PUT /nivel_malls/1.json
  def update
    respond_to do |format|
      if @nivel_mall.update(nivel_mall_params)
        format.html { redirect_to nivel_malls_index_path(nivel_mall_params[:mall_id]), notice: 'Nivel mall fue actualizado exitosamente.' }
        format.json { render :index, status: :ok, location: @nivel_mall }
      else
        format.html { render :edit }
        format.json { render json: @nivel_mall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nivel_malls/1
  # DELETE /nivel_malls/1.json
  def destroy
    @mall_id = @nivel_mall.mall_id
    @nivel_mall.destroy
    respond_to do |format|
      format.html { redirect_to nivel_malls_index_path(@mall_id), notice: 'Nivel mall se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  def test_ajax
    render :layout => nil
    respond_to do |format|
      format.json { render :index, status: :ok, location: 1 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nivel_mall
      @nivel_mall = NivelMall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nivel_mall_params
      params.require(:nivel_mall).permit(:nombre, :mall_id)
    end
end
