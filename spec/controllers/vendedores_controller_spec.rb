require 'rails_helper'

RSpec.describe VendedoresController, type: :controller do

  let(:admin) { create :administrador }

  let(:valid_attributes) { attributes_for :vendedor }
  let(:invalid_attributes) { attributes_for :vendedor, nombre: nil }

  before { sign_in admin }

  describe "GET #index" do
    it "returns a success response" do
      Vendedor.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #index"

  describe "GET #show" do
    it "returns a success response" do
      vendedor = Vendedor.create! valid_attributes
      get :show, params: { id: vendedor.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #show"

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #edit" do
    it "returns a success response" do
      vendedor = Vendedor.create! valid_attributes
      get :edit, params: { id: vendedor.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #post" do
    context "with valid params" do
      it "creates a new Vendedor" do
        expect {
          post :create, params: { vendedor: valid_attributes }
        }.to change(Vendedor, :count).by(1)
      end

      it "redirects to the created vendedor" do
        post :create, params: { vendedor: valid_attributes }
        expect(response).to redirect_to(Vendedor.last)
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'new' template" do
        post :create, params: { vendedor: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #post"

  describe "POST #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "updates the requested vendedor" do
        vendedor = Vendedor.create! valid_attributes
        put :update, params: { id: vendedor.to_param, vendedor: new_attributes }
        vendedor.reload
        expect(vendedor.nombre).to eq 'nuevo'
      end

      it "redirects to the vendedor" do
        vendedor = Vendedor.create! valid_attributes
        put :update, params: { id: vendedor.to_param, vendedor: new_attributes }
        expect(response).to redirect_to vendedor
      end
    end # context with valid params

    context "with invalid params" do
      it "display the 'edit' template" do
        vendedor = Vendedor.create! valid_attributes
        put :update, params: { id: vendedor.to_param, vendedor: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #update"

end
