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

  describe "#puede?(accion, recurso)" do

    before { allow(helper).to receive(:current_usuario).and_return(usuario) }

    context "cuando es administrador" do
      let(:usuario) { create :administrador }

      it "puede editar al cliente" do
        expect(helper.puede?(:edit, :cliente)).to be_truthy
      end
    end # context cuando es administrador

    context "cuando es vendedor" do
      let(:usuario) { create :vendedor }

      it "no puede editar al cliente" do
        expect(helper.puede?(:edit, :cliente)).to be_falsey
      end
    end # context cuando es vendedor

  end # describe "#puede?(accion, recurso)"

end
