class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update]

  def index
    @clientes = Cliente.recientes_primero
      .buscar(params[:q]).page(params[:page])
  end

  def show
  end

  def new
    @cliente = Cliente.new domicilio: Domicilio.new
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'El cliente fue creado correctamente' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @cliente.update(cliente_params)
      redirect_to @cliente, notice: 'El cliente fue actualiza correctamente'
    else
      render :edit
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(
      :nombre, :telefono, :rfc,
      domicilio_attributes: [:id, :calle, :numero, :colonia, :codigo_postal,
                             :municipio, :estado, :pais]
    )
  end
end
