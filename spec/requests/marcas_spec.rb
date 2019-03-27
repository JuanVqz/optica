require 'rails_helper'

RSpec.describe "Marcas", type: :request do
  let(:vendedor) { create :vendedor }

  before { sign_in vendedor }

  describe "GET /marcas" do
    it "debe regresar una respuesta exitosa" do
      get marcas_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /marcas/new" do
    it "debe regresar una respuesta exitosa" do
      get new_marca_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /marcas/:id" do
    let!(:tienda) { create :tienda }
    let(:marca) { create :marca }

    it "debe regresar una respuesta exitosa" do
      get marca_path marca
      expect(response).to have_http_status 200
    end

    it "debe regresar una respuesta en format pdf" do
      get marca_path marca, params: { format: :pdf }
      expect(response).to have_http_status 200
    end
  end

  describe "GET /marcas/:id/edit" do
    let(:marca) { create :marca }

    it "debe regresar una respuesta exitosa" do
      get edit_marca_path marca
      expect(response).to have_http_status 200
    end
  end

  describe "POST /marcas" do
    context "con atributos validos" do
      let(:marca) { attributes_for :marca }

      it "debe regresar una respuesta exitosa" do
        post marcas_path, params: { marca: marca }
        expect(response).to have_http_status 302
      end
    end # context con atributos validos

    context "con atributos invalidos" do
      let(:marca) { attributes_for :marca, nombre: nil }

      it "debe regresar una respuesta exitosa" do
        post marcas_path, params: { marca: marca }
        expect(response).to have_http_status 200
      end
    end # context con atributos invalidos
  end # describe "POST /marcas"

  describe "PUT /marcas/:id" do
    let(:marca) { create :marca }

    context "con atributos validos" do
      let(:atributos_marca) { attributes_for :marca, nombre: 'nuevo' }

      it "debe regresar una respuesta exitosa" do
        put marca_path marca, params: { marca: atributos_marca }
        expect(response).to have_http_status 302
      end
    end # context con atributos validos

    context "con atributos invalidos" do
      let(:atributos_marca) { attributes_for :marca, nombre: nil }

      it "debe regresar una respuesta exitosa" do
        put marca_path marca, params: { id: marca, marca: atributos_marca }
        expect(response).to have_http_status 200
      end
    end # context con atributos invalidos
  end

end
