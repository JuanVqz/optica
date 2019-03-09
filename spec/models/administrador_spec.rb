require 'rails_helper'

RSpec.describe Administrador, type: :model do

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
