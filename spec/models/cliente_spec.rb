require 'rails_helper'

RSpec.describe Cliente, type: :model do

  it { should have_many :ventas }
  it { should have_one(:domicilio).dependent(:destroy) }

  it { should validate_presence_of :nombre }
  it { should validate_uniqueness_of(:nombre).case_insensitive }
  it { should accept_nested_attributes_for(:domicilio).allow_destroy(true) }

  describe ".buscar" do
    let!(:clientes) { create_list :cliente, 4 }
    let!(:cliente) do
      create :cliente, nombre: 'Pedro', telefono: '951 111 22 33',
        rfc: 'ZZZ221212BBB'
    end

    it "regresa 1 coincidencia por nombre" do
      expect(Cliente.buscar("pedro").count).to eq 1
    end # context regresa 1 coincidencia por nombre

    it "regresa 1 coincidencia por telefono" do
      expect(Cliente.buscar("951").count).to eq 1
    end # context regresa 1 coincidencia por telefono

    it "regresa 1 coincidencia por rfc" do
      expect(Cliente.buscar("BBB").count).to eq 1
    end # context regresa 1 coincidencia por rfc
  end # describe ".buscar"

end
