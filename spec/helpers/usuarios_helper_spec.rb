require 'rails_helper'

RSpec.describe UsuariosHelper, type: :helper do

  describe "#permitir_notificar" do
    context "cuando notificar es true" do
      let(:admin) { create :administrador, notificar: true }

      it "debe ser 'SI PERMITIR'" do
        expect(permitir_notificar(admin)).to match(/SI PERMITIR/)
      end
    end # context cuando notificar es true

    context "cuando notificar es false" do
      let(:admin) { create :administrador, notificar: false }

      it "debe ser 'NO PERMITIR'" do
        expect(permitir_notificar(admin)).to match(/NO PERMITIR/)
      end
    end # context cuando notificar es false
  end # describe "#permitir_notificar"
end
