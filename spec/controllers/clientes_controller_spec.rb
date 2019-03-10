require 'rails_helper'

RSpec.describe ClientesController, type: :controller do

  let(:admin) { create :administrador }

  let(:domicilio) { attributes_for :domicilio }
  let(:valid_attributes) do
    attributes_for :cliente, domicilio_attributes: domicilio
  end
  let(:invalid_attributes) { attributes_for :cliente, nombre: nil }

  before :each do
    sign_in admin
  end

  describe "GET #index" do
    it "debe regresar una respuesta exitosa" do
      Cliente.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #index"

  describe "GET #show" do
    it "debe regresar una respuesta exitosa" do
      cliente = Cliente.create! valid_attributes
      get :show, params: { id: cliente.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #show"

  describe "GET #new" do
    it "debe regresar una respuesta exitosa" do
      get :new
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #edit" do
    it "debe regresar una respuesta exitosa" do
      cliente = Cliente.create! valid_attributes
      get :edit, params: { id: cliente.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "con atributos validos" do
      it "debe crear un nuevo Cliente" do
        expect {
          post :create, params: {cliente: valid_attributes, format: :json}
        }.to change(Cliente, :count).by(1)
      end

      it "debe crear un nuevo Domicilio" do
        expect {
          post :create, params: {cliente: valid_attributes, format: :json}
        }.to change(Domicilio, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    context "con atributos validos" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "actualiza el cliente solicitado" do
        cliente = Cliente.create! valid_attributes
        put :update, params: { id: cliente.to_param, cliente: new_attributes }
        cliente.reload
        expect(cliente.nombre).to eq 'nuevo'
      end

      it "redirige al cliente editado" do
        cliente = Cliente.create! valid_attributes
        put :update, params: { id: cliente.to_param, cliente: valid_attributes }
        expect(response).to redirect_to(cliente)
      end
    end # context with valid params

    context "con atributos invalidos" do
      it "debe mostrar la vista edit" do
        cliente = Cliente.create! valid_attributes
        put :update, params: {id: cliente.to_param, cliente: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end # describe "PUT #update"

end
