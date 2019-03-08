class VentasController < ApplicationController
  before_action :set_venta, only: [:show, :edit, :update, :destroy]

  def index
    @ventas = Venta.recientes_primero.buscar(params[:q])
      .con_cliente.con_pagos.page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @venta = current_usuario.ventas.build(venta_params)

    respond_to do |format|
      if @venta.save
        format.html { redirect_to @venta, notice: 'La venta fue creada correctamente' }
        format.json { render :show, status: :created, location: @venta }
      else
        format.html { render :new }
        format.json { render json: @venta.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @venta.update(venta_params)
        format.html { redirect_to @venta, notice: 'La venta fue actualizado correctamente' }
        format.json { render :show, status: :ok, location: @venta }
      else
        format.html { render :edit }
        format.json { render json: @venta.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @venta.destroy
    redirect_to ventas_url, notice: 'La venta fue eliminada correctamente'
  end

  private

  def set_venta
    @venta = Venta.find(params[:id])
  end

  def venta_params
    params.require(:venta).permit(
      :observaciones, :saldada, :fecha_entrega,
      :descuento, :total, :cliente_id,
      pagos_attributes: [:efectivo, :anticipo, :cambio],
      vendidos_attributes: [
        :id, :producto_id, :cantidad, :precio_venta, :precio_compra,
        :descuento, :subtotal
      ]
    )
  end
end
