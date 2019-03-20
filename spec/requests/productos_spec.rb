require 'rails_helper'

RSpec.describe "Productos", type: :request do

  let!(:tienda) { create :tienda }
  let(:vendedor) { create :vendedor }

  before { sign_in vendedor }

  describe "GET /armazones/1.pdf" do
    let(:armazon) { create :armazon }

    it "regresa una respuesta en formato pdf" do
      get armazon_path armazon, params: { format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /armazones/1.pdf"

  describe "GET /lentes/1.pdf" do
    let(:lente) { create :lente }

    it "regresa una respuesta en formato pdf" do
      get lente_path lente, params: { format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /lentes/1.pdf"

  describe "GET /micas/1.pdf" do
    let(:mica) { create :mica }

    it "regresa una respuesta en formato pdf" do
      get mica_path mica, params: { format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /micas/1.pdf"

  describe "GET /tratamientos/1.pdf" do
    let(:tratamiento) { create :tratamiento }

    it "regresa una respuesta en formato pdf" do
      get tratamiento_path tratamiento, params: { format: :pdf }
      expect(response).to have_http_status 200
    end
  end # describe "GET /tratamientos/1.pdf"

end
