class CodigosDeBarrasController < ApplicationController

  def index
  end

  def productos
    @productos = modelo.all

    respond_to do |format|
      format.html
      format.pdf {
        render pdf: "codigos_de_barras_de_#{modelo}",
        template: 'pdfs/codigos_de_barras/productos'
      }
    end
  end

  private

  def modelo
    params.require(:tipo).classify.constantize
  end

end
