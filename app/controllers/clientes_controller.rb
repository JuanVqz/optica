class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update]

  def index
    @clientes = Cliente.recientes_primero
      .con_corporacion.buscar(params[:q]).page(params[:page])
    authorize @clientes
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf { render configuracion_pdf('cliente') }
    end
  end

  def new
    @cliente = Cliente.new domicilio: Domicilio.new
    authorize @cliente
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)
    authorize @cliente

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'El cliente fue creado correctamente' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
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

  def nombre_pdf
    @cliente.to_s.parameterize.underscore
  end

  def set_cliente
    @cliente = Cliente.find(params[:id])
    authorize @cliente
  end

  def cliente_params
    params.require(:cliente).permit(
      :nombre, :telefono, :rfc, :corporacion_id,
      domicilio_attributes: [:id, :calle, :numero, :colonia, :codigo_postal,
                             :municipio, :estado, :pais]
    )
  end
end
