class CalendarioNoLaborablesController < ApplicationController
  before_action :set_calendario_no_laborable, only: [:show, :edit, :update, :destroy]

  # GET /calendario_no_laborables
  # GET /calendario_no_laborables.json
  def index
    @calendario_no_laborables = CalendarioNoLaborable.all
  end

  # GET /calendario_no_laborables/1
  # GET /calendario_no_laborables/1.json
  def show
  end

  # GET /calendario_no_laborables/new
  def new
    @calendario_no_laborable = CalendarioNoLaborable.new
  end

  # GET /calendario_no_laborables/1/edit
  def edit
  end

  # POST /calendario_no_laborables
  # POST /calendario_no_laborables.json
  def create
    @calendario_no_laborable = CalendarioNoLaborable.new(calendario_no_laborable_params)

    respond_to do |format|
      if @calendario_no_laborable.save
        format.html { redirect_to @calendario_no_laborable, notice: 'Calendario no laborable was successfully created.' }
        format.json { render :show, status: :created, location: @calendario_no_laborable }
      else
        format.html { render :new }
        format.json { render json: @calendario_no_laborable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendario_no_laborables/1
  # PATCH/PUT /calendario_no_laborables/1.json
  def update
    respond_to do |format|
      if @calendario_no_laborable.update(calendario_no_laborable_params)
        format.html { redirect_to @calendario_no_laborable, notice: 'Calendario no laborable was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendario_no_laborable }
      else
        format.html { render :edit }
        format.json { render json: @calendario_no_laborable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendario_no_laborables/1
  # DELETE /calendario_no_laborables/1.json
  def destroy
    @calendario_no_laborable.destroy
    respond_to do |format|
      format.html { redirect_to calendario_no_laborables_url, notice: 'Calendario no laborable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendario_no_laborable
      @calendario_no_laborable = CalendarioNoLaborable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendario_no_laborable_params
      params.require(:calendario_no_laborable).permit(:fecha, :motivo)
    end
end
