class MicasController < ApplicationController
  before_action :set_mica, only: [:show, :edit, :update, :destroy]

  def index
    @micas = Mica.recientes_primero.buscar(params[:q]).page(params[:page])
  end

  def show
  end

  def new
    @mica = Mica.new
  end

  def edit
  end

  def create
    @mica = current_usuario.micas.build(mica_params)

    if @mica.save
      redirect_to @mica, notice: 'La mica fue creada correctamente'
    else
      render :new
    end
  end

  def update
    if @mica.update(mica_params)
      redirect_to @mica, notice: 'La mica fue creada correctamente'
    else
      render :edit
    end
  end

  def destroy
    @mica.destroy
    redirect_to micas_url, notice: 'La mica fue eliminada correctamente'
  end

  private

  def set_mica
    @mica = Mica.find(params[:id])
  end

  def mica_params
    params.require(:mica).permit(
      :nombre, :codigo, :descripcion, :precio_venta, :precio_compra,
      :existencia, :tipo, :publicado, :marca_id, { imagenes: [] }
    )
  end
end
