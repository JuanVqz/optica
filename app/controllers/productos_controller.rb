class ProductosController < ApplicationController

  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf { render configuracion_pdf('producto') }
    end
  end

  private

  def nombre_pdf
    @producto.to_s.parameterize.underscore
  end

end
