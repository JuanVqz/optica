class MarcasController < ApplicationController
  before_action :set_marca, only: [:show, :edit, :update, :destroy]

  def index
    @marcas = Marca.recientes_primero.con_productos.buscar(params[:q]).page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf {
        render pdf: 'marca',
        template: 'pdfs/marcas/marca',
        margin: { top: '30', bottom: '10' }
      }
    end
  end

  def new
    @marca = Marca.new
  end

  def edit
  end

  def create
    @marca = Marca.new(marca_params)

    if @marca.save
      redirect_to @marca, notice: 'La marca fue creada correctamente'
    else
      render :new
    end
  end

  def update
    if @marca.update(marca_params)
      redirect_to @marca, notice: 'La marca fue actualizada correctamente'
    else
      render :edit
    end
  end

  def destroy
    @marca.destroy
    redirect_to marcas_url, notice: 'La marca fue eliminada correctamente'
  end

  private

  def set_marca
    @marca = Marca.find(params[:id])
  end

  def marca_params
    params.require(:marca).permit(:nombre, :descripcion)
  end
end
