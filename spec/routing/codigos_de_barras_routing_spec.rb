require "rails_helper"

RSpec.describe CodigosDeBarrasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/codigos_de_barras").to route_to("codigos_de_barras#index")
    end

    it "routes to #productos?tipo=armazon" do
      expect(get: "/codigos_de_barras/productos?tipo=armazon").to route_to("codigos_de_barras#productos", "tipo": "armazon")
    end

    it "routes to #productos?tipo=lente" do
      expect(get: "/codigos_de_barras/productos?tipo=lente").to route_to("codigos_de_barras#productos", "tipo": "lente")
    end

    it "routes to #productos?tipo=mica" do
      expect(get: "/codigos_de_barras/productos?tipo=mica").to route_to("codigos_de_barras#productos", "tipo": "mica")
    end

    it "routes to #productos?tipo=tratamiento" do
      expect(get: "/codigos_de_barras/productos?tipo=tratamiento").to route_to("codigos_de_barras#productos", "tipo": "tratamiento")
    end

  end
end
