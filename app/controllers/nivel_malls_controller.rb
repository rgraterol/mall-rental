class NivelMallsController < ApplicationController
  before_action :set_nivel_mall, only: [:show, :edit, :update, :destroy]

  # GET /nivel_malls
  # GET /nivel_malls.json
  def index
    @nivel_malls = NivelMall.all
  end

  # GET /nivel_malls/1
  # GET /nivel_malls/1.json
  def show
  end

  # GET /nivel_malls/new
  def new
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
        format.html { redirect_to @nivel_mall, notice: 'Nivel mall was successfully created.' }
        format.json { render :show, status: :created, location: @nivel_mall }
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
        format.html { redirect_to @nivel_mall, notice: 'Nivel mall was successfully updated.' }
        format.json { render :show, status: :ok, location: @nivel_mall }
      else
        format.html { render :edit }
        format.json { render json: @nivel_mall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nivel_malls/1
  # DELETE /nivel_malls/1.json
  def destroy
    @nivel_mall.destroy
    respond_to do |format|
      format.html { redirect_to nivel_malls_url, notice: 'Nivel mall was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nivel_mall
      @nivel_mall = NivelMall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nivel_mall_params
      params.require(:nivel_mall).permit(:nombre)
    end
end
