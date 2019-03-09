require 'rails_helper'

RSpec.describe ProductosHelper, type: :helper do

  describe "#estado_de_publicacion" do
    context "cuando publicado es true" do
      let(:armazon) { create :armazon, publicado: true }
      let(:lente) { create :lente, publicado: true }
      let(:mica) { create :mica, publicado: true }
      let(:tratamiento) { create :tratamiento, publicado: true }

      it "debe ser 'PUBLICADO'" do
        expect(estado_de_publicacion(armazon)).to match(/PUBLICADO/)
        expect(estado_de_publicacion(lente)).to match(/PUBLICADO/)
        expect(estado_de_publicacion(mica)).to match(/PUBLICADO/)
        expect(estado_de_publicacion(tratamiento)).to match(/PUBLICADO/)
      end
    end # context cuando publicado es true

    context "cuando publicado es false" do
      let(:armazon) { create :armazon, publicado: false }
      let(:lente) { create :lente, publicado: false }
      let(:mica) { create :mica, publicado: false }
      let(:tratamiento) { create :tratamiento, publicado: false }

      it "debe ser 'NO PUBLICADO'" do
        expect(estado_de_publicacion(armazon)).to match(/NO PUBLICADO/)
        expect(estado_de_publicacion(lente)).to match(/NO PUBLICADO/)
        expect(estado_de_publicacion(mica)).to match(/NO PUBLICADO/)
        expect(estado_de_publicacion(tratamiento)).to match(/NO PUBLICADO/)
      end
    end # context cuando publicado es false
  end # describe "#estado_de_publicacion"
end
