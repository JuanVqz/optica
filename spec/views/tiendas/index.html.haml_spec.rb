require 'rails_helper'

RSpec.describe "tiendas/index", type: :view do
  before(:each) do
    assign(:tiendas, Kaminari.paginate_array([
      Tienda.create!(
        nombre: "Nombre",
        rfc: "Rfc",
        pagina_web: "optica.com",
        eslogan: "Eslogan",
        logotipo: FactoryBotHelpers.subir_archivo(nombre: 'opticajj.jpg', formato: 'jpg')
      ),
      Tienda.create!(
        nombre: "Nombre",
        rfc: "Rfc",
        pagina_web: "optica.com",
        eslogan: "Eslogan",
        logotipo: FactoryBotHelpers.subir_archivo(nombre: 'opticajj.jpg', formato: 'jpg')
      )
    ]).page(1))
  end

  it "muestra la lista de tiendas" do
    render
    assert_select "tr>td", text: "Nombre".to_s, count: 2
    assert_select "tr>td", text: "Rfc".to_s, count: 2
  end
end
