require 'rails_helper'

RSpec.describe MarcasController, type: :controller do

  let(:vendedor) { create :vendedor }
  let(:valid_attributes) { attributes_for :marca }
  let(:invalid_attributes) { attributes_for :marca, nombre: nil }

  before { sign_in vendedor }

  describe "GET #index" do
    it "returns a success response" do
      Marca.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      marca = Marca.create! valid_attributes
      get :show, params: {id: marca.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      marca = Marca.create! valid_attributes
      get :edit, params: {id: marca.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Marca" do
        expect {
          post :create, params: {marca: valid_attributes}
        }.to change(Marca, :count).by(1)
      end

      it "redirects to the created marca" do
        post :create, params: {marca: valid_attributes}
        expect(response).to redirect_to(Marca.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {marca: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "updates the requested marca" do
        marca = Marca.create! valid_attributes
        put :update, params: {id: marca.to_param, marca: new_attributes}
        marca.reload
        expect(marca.nombre).to eq 'nuevo'
      end

      it "redirects to the marca" do
        marca = Marca.create! valid_attributes
        put :update, params: {id: marca.to_param, marca: valid_attributes}
        expect(response).to redirect_to(marca)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        marca = Marca.create! valid_attributes
        put :update, params: {id: marca.to_param, marca: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested marca" do
      marca = Marca.create! valid_attributes
      expect {
        delete :destroy, params: {id: marca.to_param}
      }.to change(Marca, :count).by(-1)
    end

    it "redirects to the marcas list" do
      marca = Marca.create! valid_attributes
      delete :destroy, params: {id: marca.to_param}
      expect(response).to redirect_to(marcas_url)
    end
  end

end
