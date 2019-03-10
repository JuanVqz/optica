require 'rails_helper'

RSpec.describe "Empresas", type: :request do

  let(:administrador) { create :administrador }

  before :each do
    sign_in administrador
  end

  describe "GET /empresas" do
    it "debe regresar una respuesta exitosa" do
      get empresas_path
      expect(response).to have_http_status(200)
    end
  end # describe "GET /empresas"

  describe "GET /empresas/:id" do
    let(:empresa) { create :empresa }
    it "debe regresar una respuesta exitosa" do
      get empresas_path empresa
      expect(response).to have_http_status(200)
    end
  end # describe "GET /empresas/:id"

  describe "GET /empresas/new" do
    it "debe regresar una respuesta exitosa" do
      get new_empresa_path
      expect(response).to have_http_status(200)
    end
  end # describe "GET /empresas/new"

  describe "POST /empresas" do
    context "con atributos validos" do
      let(:empresa) { attributes_for :empresa }

      it "redirige a la empresa creada" do
        post empresas_path, params: { empresa: empresa }
        expect(response).to have_http_status(302)
      end
    end # context con atributos validos

    context "con atributos invalidos" do
      let(:empresa) { attributes_for :empresa, nombre: nil }

      it "debe regresar una respuesta exitosa" do
        post empresas_path, params: { empresa: empresa }
        expect(response).to have_http_status(200)
      end
    end # context con attributos invalidos
  end # describe "POST /empresas"

  describe "GET /empresas/:id/edit" do
    let(:empresa) { create :empresa }

    it "debe regresar una respuesta exitosa" do
      get edit_empresa_path empresa
      expect(response).to have_http_status(200)
    end
  end # describe "GET /empresas/:id/edit"

end
