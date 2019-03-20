class ProductosController < ApplicationController

  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf { render configuracion_pdf }
    end
  end

  private

  def configuracion_pdf
    {
      pdf: nombre_pdf,
      template: 'pdfs/producto/producto',
      margin: { top: '30', bottom: '10' },
      header: { html: { template: 'pdfs/producto/cabeza' } },
      footer: { html: { template: 'pdfs/producto/pie' } }
    }
  end

  def nombre_pdf
    @producto.to_s.parameterize.underscore
  end

end
