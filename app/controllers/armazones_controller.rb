class ArmazonesController < ApplicationController
  before_action :set_armazon, only: [:show, :edit, :update, :destroy]

  def index
    @armazones = Armazon.recientes_primero
      .buscar(params[:q]).page(params[:page])
  end

  def show
  end

  def new
    @armazon = Armazon.new
  end

  def edit
  end

  def create
    @armazon = current_usuario.armazones.build(armazon_params)

    if @armazon.save
      redirect_to @armazon, notice: 'El armazon fue creado correctamente'
    else
      render :new
    end
  end

  def update
    if @armazon.update(armazon_params)
      redirect_to @armazon, notice: 'El armazon fue actualizado correctamente'
    else
      render :edit
    end
  end

  def destroy
    @armazon.destroy
    redirect_to armazones_url, notice: 'El armazon fue eliminado correctamente'
  end

  private

  def set_armazon
    @armazon = Armazon.find(params[:id])
  end

  def armazon_params
    params.require(:armazon).permit(
      :nombre, :codigo, :descripcion, :precio_venta, :precio_compra,
      :existencia, :tipo, { imagenes: [] }
    )
  end
end
