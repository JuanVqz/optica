require 'rails_helper'

RSpec.describe AdministradoresController, type: :controller do
  let(:administrador) { create :administrador }

  let(:valid_attributes) { attributes_for :administrador }
  let(:invalid_attributes) { attributes_for :administrador, nombre: nil }

  before { sign_in administrador }

  describe "GET #index" do
    it "regresa una respuesta exitosa" do
      Administrador.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #index"

  describe "GET #show" do
    it "regresa una respuesta exitosa" do
      administrador = Administrador.create! valid_attributes
      get :show, params: { id: administrador.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #show"

  describe "GET #new" do
    it "regresa una respuesta exitosa" do
      get :new
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #edit" do
    it "regresa una respuesta exitosa" do
      administrador = Administrador.create! valid_attributes
      get :edit, params: { id: administrador.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "con atributos validos" do
      it "crea un nuevo Administrador" do
        expect {
          post :create, params: { administrador: valid_attributes }
        }.to change(Administrador, :count).by(1)
      end

      it "redirecciona al administrador creado" do
        post :create, params: { administrador: valid_attributes }
        expect(response).to redirect_to(Administrador.last)
      end
    end # context con atributos validos

    context "con atributos invalidos" do
      it "muestra la vista 'new'" do
        post :create, params: { administrador: invalid_attributes }
        expect(response).to be_successful
      end
    end # context con atributos invalidos
  end # describe "POST #create"

  describe "POST #update" do
    context "con atributos validos" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "actualiza el cliente solicitado" do
        administrador = Administrador.create! valid_attributes
        put :update, params: { id: administrador.to_param, administrador: new_attributes }
        administrador.reload
        expect(administrador.nombre).to eq 'nuevo'
      end

      it "redirects to the administrador" do
        administrador = Administrador.create! valid_attributes
        put :update, params: { id: administrador.to_param, administrador: new_attributes }
        expect(response).to redirect_to administrador
      end
    end # context con atributos validos

    context "con atributos invalidos" do
      it "debe mostrar la vista edit" do
        administrador = Administrador.create! valid_attributes
        put :update, params: { id: administrador.to_param, administrador: invalid_attributes }
        expect(response).to be_successful
      end
    end # context con atributos invalidos
  end # describe "POST #update"
end
