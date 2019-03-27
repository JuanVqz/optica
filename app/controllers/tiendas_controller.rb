class TiendasController < ApplicationController
  before_action :set_tienda, only: [:show, :edit, :update, :destroy]

  def index
    @tiendas = Tienda.recientes_primero.page(params[:page])
    authorize @tiendas
  end

  def show
  end

  def new
    @tienda = Tienda.new domicilio: Domicilio.new
    authorize @tienda
  end

  def edit
  end

  def create
    @tienda = Tienda.new(tienda_params)
    authorize @tienda

    if @tienda.save
      redirect_to @tienda, notice: 'La tienda fue creada correctamente'
    else
      render :new
    end
  end

  def update
    if @tienda.update(tienda_params)
      redirect_to @tienda, notice: 'La tienda fue actualzada correctamente'
    else
      render :edit
    end
  end

  def destroy
    @tienda.destroy
    redirect_to tiendas_url, notice: 'La tienda fue eliminada correctamente'
  end

  private

  def set_tienda
    @tienda = Tienda.find(params[:id])
    authorize @tienda
  end

  def tienda_params
    params.require(:tienda).permit(
      :nombre, :telefono, :rfc, :eslogan, :logotipo,
      :logotipo_cache, :leyenda_boleto, :pagina_web,
      domicilio_attributes: [:id, :calle, :numero, :colonia, :codigo_postal,
                             :municipio, :estado, :pais]
    )
  end
end
