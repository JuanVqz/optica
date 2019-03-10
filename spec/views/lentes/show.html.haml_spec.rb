require 'rails_helper'

RSpec.describe "lentes/show", type: :view do

  let(:vendedor) { create :vendedor }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    @lente = assign(:lente, Lente.create!(
      nombre: "lente 2",
      codigo: "LN2",
      descripcion: "descripción del lente 2",
      precio_venta: 100,
      precio_compra: 0,
      existencia: 10,
      tipo: "polarizado",
      usuario: vendedor
    ))
  end

  context "cuando es administrador" do
    let(:usuario) { create :administrador }

    it "muestra precio_compra y los atributos" do
      render
      expect(rendered).to match(/0/)
      expect(rendered).to match(/lente 2/)
      expect(rendered).to match(/LN2/)
      expect(rendered).to match(/polarizado/)
    end
  end

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no muestra precio_compra" do
      render
      expect(rendered).to match(/lente 2/)
      expect(rendered).to match(/LN2/)
      expect(rendered).to match(/polarizado/)
    end
  end
end
