require 'rails_helper'

RSpec.describe "clientes/index", type: :view do
  let(:domicilio) { attributes_for :domicilio }

  before(:each) do
    allow(view).to receive(:current_usuario).and_return(usuario)

    assign(:clientes, Kaminari.paginate_array([
      Cliente.create!(
        :nombre => "Nombre",
        :rfc => "Rfc",
        :telefono => "Telefono",
        :domicilio_attributes => domicilio
      ),
      Cliente.create!(
        :nombre => "Nombre 2",
        :rfc => "Rfc",
        :telefono => "Telefono",
        :domicilio_attributes => domicilio
      )
    ]).page(1))
  end

  context "cuando es administrador" do
    let(:usuario) { create :administrador }

    it "debe mostrar el boton editar" do
      render

      expect(rendered).to match(/editar/)

      assert_select "tr>td", :text => "Nombre".to_s, :count => 1
      assert_select "tr>td", :text => "Rfc".to_s, :count => 2
      assert_select "tr>td", :text => "Telefono".to_s, :count => 2
    end
  end # context cuando es administrador

  context "cuando es vendedor" do
    let(:usuario) { create :vendedor }

    it "no debe mostrar el boton editar" do
      render

      expect(rendered).not_to match(/editar/)

      assert_select "tr>td", :text => "Nombre".to_s, :count => 1
      assert_select "tr>td", :text => "Rfc".to_s, :count => 2
      assert_select "tr>td", :text => "Telefono".to_s, :count => 2
    end
  end # context cuando es vendedor
end
