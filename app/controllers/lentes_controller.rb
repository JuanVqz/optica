class LentesController < ApplicationController
  before_action :set_lente, only: [:show, :edit, :update, :destroy]

  def index
    @lentes = Lente.recientes_primero.buscar(params[:q]).page(params[:page])
  end

  def show
  end

  def new
    @lente = Lente.new
  end

  def edit
  end

  def create
    @lente = current_usuario.lentes.build(lente_params)

    if @lente.save
      redirect_to @lente, notice: 'El lente fue creado correctamente'
    else
      render 'new'
    end
  end

  def update
    if @lente.update(lente_params)
      redirect_to @lente, notice: 'El lente fue actualizado correctamente'
    else
      render 'edit'
    end
  end

  def destroy
    @lente.destroy
    redirect_to lentes_url, notice: 'El lente fue eliminado correctamente'
  end

  private

  def set_lente
    @lente = Lente.find(params[:id])
  end

  def lente_params
    params.require(:lente).permit(
      :nombre, :codigo, :descripcion, :precio_venta, :precio_compra,
      :existencia, :tipo
    )
  end
end
