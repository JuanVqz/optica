require 'rails_helper'

RSpec.describe "CodigosDeBarras", type: :request do

  let(:admin) { create :administrador }

  before { sign_in admin }

  describe "GET /codigos_de_barras" do
    it "regresa una respuesta exitosa" do
      get codigos_de_barras_path
      expect(response).to have_http_status 200
    end
  end # describe "GET /codigos_de_barras"

  describe "GET /codigos_de_barras/productos?tipo=armazon" do
    it "regresa una respuesta en formato pdf" do
      get productos_codigos_de_barras_path, params: { tipo: 'armazon', format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /codigos_de_barras/productos?tipo=armazon"

  describe "GET /codigos_de_barras/productos?tipo=lente" do
    it "regresa una respuesta en formato pdf" do
      get productos_codigos_de_barras_path, params: { tipo: 'lente', format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /codigos_de_barras/productos?tipo=lente"

  describe "GET /codigos_de_barras/productos?tipo=mica" do
    it "regresa una respuesta en formato pdf" do
      get productos_codigos_de_barras_path, params: { tipo: 'mica', format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /codigos_de_barras/productos?tipo=mica"

  describe "GET /codigos_de_barras/productos?tipo=tratamiento" do
    it "regresa una respuesta en formato pdf" do
      get productos_codigos_de_barras_path, params: { tipo: 'tratamiento', format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /codigos_de_barras/productos?tipo=tratamiento"

end
