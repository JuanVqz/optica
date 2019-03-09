class TratamientosController < ApplicationController
  before_action :set_tratamiento, only: [:show, :edit, :update, :destroy]

  def index
    @tratamientos = Tratamiento.recientes_primero
      .buscar(params[:q]).page(params[:page])
  end

  def show
  end

  def new
    @tratamiento = Tratamiento.new
  end

  def edit
  end

  def create
    @tratamiento = current_usuario.tratamientos.build(tratamiento_params)

    if @tratamiento.save
      redirect_to @tratamiento, notice: 'El tratamiento fue creada correctamente'
    else
      render :new
    end
  end

  def update
    if @tratamiento.update(tratamiento_params)
      redirect_to @tratamiento, notice: 'El tratamiento fue creada correctamente'
    else
      render :edit
    end
  end

  def destroy
    @tratamiento.destroy
    redirect_to tratamiento_url, notice: 'El tratamiento fue eliminada correctamente'
  end

  private

  def set_tratamiento
    @tratamiento = Tratamiento.find(params[:id])
  end

  def tratamiento_params
    params.require(:tratamiento).permit(
      :nombre, :codigo, :descripcion, :precio_venta, :precio_compra,
      :existencia, { imagenes: [] }
    )
  end
end
