class LocalsController < ApplicationController
  before_action :set_local, only: [:show, :edit, :update, :destroy]

  # GET /locals
  # GET /locals.json
  def index
    @locals = Local.all
    @origen = 'index'
    @local1 = Local.new
    @local2 = Local.new
  end

  # GET /locals/1
  # GET /locals/1.json
  def show
  end

  # GET /locals/new
  def new
    @local = Local.new
    @mall = Mall.where(id: params[:id])
  end

  # GET /locals/1/edit
  def edit
  end

  # POST /locals
  # POST /locals.json
  def create
    @local = Local.new(local_params)

    respond_to do |format|
      if @local.save

        uploaded_io = params[:local][:foto]
        @nam = uploaded_io.original_filename
        @aux = @nam.split('.')
        @extension = @aux[1]

        @image_filename = 'foto_'+@local.id.to_s+'.'+@extension
        @local.update(foto: @image_filename)

        File.open(Rails.root.join('public', 'uploads',@image_filename),'wb') do |file|
          file.write(uploaded_io.read)
        end

        format.html { redirect_to :action => "index", notice: 'Local fue creado satisfactoriamente.' }
        format.json { render :index, status: :created, location: @local }
      else
        format.html { render :new }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locals/1
  # PATCH/PUT /locals/1.json
  def update
    respond_to do |format|
      if @local.update(local_params)
        format.html { redirect_to :action => "index", notice: 'Local fue actualizado satisfactoriamente.' }
        format.json { render :index, status: :ok, location: @local }
      else
        format.html { render :edit }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locals/1
  # DELETE /locals/1.json
  def destroy
    @local.destroy
    respond_to do |format|
      format.html { redirect_to locals_url, notice: 'Local eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def localsmall
    @mall = Mall.find(params[:id])
    @locals = Local.where(mall_id: @mall.id)
    @origen = 'localsmall'
    @local1 = Local.new
    @local2 = Local.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local
      @local = Local.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_params
      params.require(:local).permit(:foto, :nro_local, :direccion, :ubicacion_pasillo, :area, :propiedad_mall, :tipo_local_id, :nivel_mall_id, :mall_id)
    end
end
