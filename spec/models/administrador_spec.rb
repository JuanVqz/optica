require 'rails_helper'

RSpec.describe Administrador, type: :model do

  describe ".notificar" do
    let!(:administradores) { create_list :administrador, 3, notificar: false }

    context "cuando notificar es true" do
      let(:admin) { create :administrador, notificar: true }

      it "debe regresar un administrador" do
        expect(Administrador.notificar).to eq [admin]
      end
    end # context cuando notificar es true

    context "cuando notificar es false" do
      it "no debe regresar administradores" do
        expect(Administrador.notificar).to eq []
      end
    end # context cuando notificar es false
  end # describe "#notificar"

  describe "#establecer_cargo" do
    context "con cargo 'vendedor'" do
      let(:admin) { create :administrador, cargo: 'vendedor' }

      it "dene ser 'admin'" do
        expect(admin.cargo).to eq 'admin'
      end
    end # context con cargo 'vendedor'

    context "sin cargo" do
      let(:admin) { create :administrador, cargo: nil }

      it "debe ser 'admin'" do
        expect(admin.cargo).to eq 'admin'
      end
    end # context sin cargo
  end # describe "#establecer_cargo"

end
