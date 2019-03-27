require 'rails_helper'

RSpec.describe "tiendas/show", type: :view do
  before(:each) do
    @tienda = assign(:tienda, Tienda.create!(
      nombre: "Nombre",
      rfc: "Rfc",
      pagina_web: "optica.com",
      leyenda_boleto: "este boleto no es un comprobante fiscal",
      eslogan: "Eslogan",
      logotipo: FactoryBotHelpers.subir_archivo(nombre: 'opticajj.jpg', formato: 'jpg')
    ))
  end

  it "se muestran los atributos" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Rfc/)
    expect(rendered).to match(/Eslogan/)
    expect(rendered).to match(/optica.com/)
    expect(rendered).to match(/este boleto no es un comprobante fiscal/)
  end
end
