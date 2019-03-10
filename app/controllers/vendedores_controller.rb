class VendedoresController < ApplicationController
  before_action :set_vendedor, only: [:show, :edit, :update]

  def index
    @vendedores = Vendedor.recientes_primero.page(params[:page])
    authorize @vendedores
  end

  def show
  end

  def new
    @vendedor = Vendedor.new
    authorize @vendedor
  end

  def edit
  end

  def create
    @vendedor = Vendedor.new(vendedor_params)
    authorize @vendedor

    if @vendedor.save
      redirect_to @vendedor, notice: 'El vendedor fue creado correctamente'
    else
      render :new
    end
  end

  def update
    if @vendedor.update(vendedor_params)
      redirect_to @vendedor, notice: 'El vendedor fue actualizado correctamente'
    else
      render 'edit'
    end
  end

  private

  def set_vendedor
    @vendedor = Vendedor.find(params[:id])
    authorize @vendedor
  end

  def vendedor_params
    params.require(:vendedor).permit(
      :nombre, :telefono, :email, :password, :password_confirmation, :activo
    )
  end
end
