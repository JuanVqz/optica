require 'rails_helper'

RSpec.describe ArmazonesController, type: :controller do

  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  let(:valid_attributes) do
    attributes_for :armazon, usuario_id: vendedor.id, marca_id: marca.id
  end
  let(:invalid_attributes) { attributes_for :armazon, nombre: nil }

  before { sign_in vendedor }

  describe "GET #index" do
    it "returns a success response" do
      Armazon.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #show" do
    it "returns a success response" do
      armazon = Armazon.create! valid_attributes
      get :show, params: { id: armazon.to_param }
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
      armazon = Armazon.create! valid_attributes
      get :edit, params: { id: armazon.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Armazon" do
        expect {
          post :create, params: { armazon: valid_attributes }
        }.to change(Armazon, :count).by(1)
      end

      it "redirects to the created armazon" do
        post :create, params: { armazon: valid_attributes }
        expect(response).to redirect_to Armazon.last
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'new' template" do
        post :create, params: { armazon: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #create"

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "updates the requested armazon" do
        armazon = Armazon.create! valid_attributes
        put :update, params: { id: armazon.to_param, armazon: new_attributes }
        armazon.reload
        expect(armazon.nombre).to eq 'nuevo'
      end

      it "redirects to the armazon" do
        armazon = Armazon.create! valid_attributes
        put :update, params: { id: armazon.to_param, armazon: valid_attributes }
        expect(response).to redirect_to(armazon)
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'edit' template" do
        armazon = Armazon.create! valid_attributes
        put :update, params: { id: armazon.to_param, armazon: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #update"

  describe "DELETE #destroy" do
    it "destroys the requested armazon" do
      armazon = Armazon.create! valid_attributes
      expect {
        delete :destroy, params: { id: armazon.to_param }
      }.to change(Armazon, :count).by(-1)
    end

    it "redirects to the armazones list" do
      armazon = Armazon.create! valid_attributes
      delete :destroy, params: { id: armazon.to_param }
      expect(response).to redirect_to(armazones_url)
    end
  end # describe "DELETE #destroy"

end
