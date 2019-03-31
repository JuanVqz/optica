require 'rails_helper'

RSpec.describe SuperUsuario, type: :model do

  describe "#establecer_cargo" do
    context "con cargo 'superusuario'" do
      let(:superusuario) { create :super_usuario, cargo: 'vendedor' }

      it "debe ser 'superusuario'" do
        expect(superusuario.cargo).to eq 'superusuario'
      end
    end # context con cargo 'superusuario'

    context "sin cargo" do
      let(:superusuario) { create :super_usuario, cargo: nil }

      it "debe ser 'superusuario'" do
        expect(superusuario.cargo).to eq 'superusuario'
      end
    end # context sin cargo
  end # describe "#establecer_cargo"

end
