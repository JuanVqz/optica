class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  def index
    @empresas = Empresa.recientes_primero
    authorize @empresas
  end

  def show
  end

  def new
    @empresa = Empresa.new domicilio: Domicilio.new
    authorize @empresa
  end

  def edit
  end

  def create
    @empresa = Empresa.new(empresa_params)
    authorize @empresa

    if @empresa.save
      redirect_to @empresa, notice: 'La empresa fue creada correctamente'
    else
      render :new
    end
  end

  def update
    if @empresa.update(empresa_params)
      redirect_to @empresa, notice: 'La empresa fue actualzada correctamente'
    else
      render :edit
    end
  end

  def destroy
    @empresa.destroy
    redirect_to empresas_url, notice: 'La empresa fue eliminada correctamente'
  end

  private

  def set_empresa
    @empresa = Empresa.find(params[:id])
    authorize @empresa
  end

  def empresa_params
    params.require(:empresa).permit(
      :nombre, :telefono, :rfc, :eslogan, :logotipo, :logotipo_cache,
      domicilio_attributes: [:id, :calle, :numero, :colonia, :codigo_postal,
                             :municipio, :estado, :pais]
    )
  end
end
