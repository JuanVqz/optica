require 'rails_helper'

RSpec.describe "Clientes", type: :request do

  let(:vendedor) { create :vendedor }
  let(:atributos_validos) { attributes_for :cliente }
  let(:atributos_invalidos) { attributes_for :cliente, nombre: nil }

  before :each do
    sign_in vendedor
  end

  describe "GET /clientes" do
    it "debe regresar una respuesta exitosa" do
      get clientes_path
      expect(response).to have_http_status 200
    end
  end # describe "GET /clientes"

  describe "GET /clientes/:id" do
    let(:cliente) { create :cliente }

    it "debe regresar una respuesta exitosa" do
      get cliente_path cliente
      expect(response).to have_http_status 200
    end

    it "debe regresar una respuesta exitosa en json" do
      get cliente_path cliente, params: { format: :json }
      expect(response).to have_http_status 200
    end
  end # describe "GET /clientes/:id"

  describe "GET /clientes/new" do
    it "debe regresar una respuesta exitosa" do
      get new_cliente_path
      expect(response).to have_http_status 200
    end
  end # describe "GET /clientes/new"

  describe "GET /clientes/:id/edit" do
    let(:cliente) { create :cliente }

    it "debe regresar una respuesta exitosa" do
      get edit_cliente_path cliente
      expect(response).to have_http_status 200
    end
  end # describe "GET /clientes/:id/edit"

  describe "POST /clientes" do
    context "con parámetros válidos" do
      it "debe regresa una respuesta exitosa" do
        post clientes_path, params: { cliente: atributos_validos, format: :json }
        expect(response).to have_http_status(:created)
      end
    end # context con parámetros válidos

    context "con parámetros inválidos" do
      it "debe regresar una respuesta exitosa" do
        post clientes_path, params: { cliente: atributos_invalidos, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end # context con parámetros inválidos
  end # describe "POST /clientes"

end
