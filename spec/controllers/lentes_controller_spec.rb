require 'rails_helper'

RSpec.describe LentesController, type: :controller do

  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  let(:valid_attributes) do
    attributes_for :lente, usuario_id: vendedor.id, marca_id: marca.id
  end
  let(:invalid_attributes) { attributes_for :lente, nombre: nil }

  before { sign_in vendedor }

  describe "GET #index" do
    it "returns a success response" do
      Lente.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #show" do
    it "returns a success response" do
      lente = Lente.create! valid_attributes
      get :show, params: { id: lente.to_param }
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
      lente = Lente.create! valid_attributes
      get :edit, params: { id: lente.to_param, lente: valid_attributes }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Lente" do
        expect {
          post :create, params: { lente: valid_attributes }
        }.to change(Lente, :count).by(1)
      end

      it "redirects to the created lente" do
        post :create, params: { lente: valid_attributes }
        expect(response).to redirect_to Lente.last
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'new' template" do
        post :create, params: { lente: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #create"

  describe "POST #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "updates the requested lente" do
        lente = Lente.create! valid_attributes
        put :update, params: { id: lente.to_param, lente: new_attributes }
        lente.reload
        expect(lente.nombre).to eq 'nuevo'
      end

      it "redirects to the lente" do
        lente = Lente.create! valid_attributes
        put :update, params: { id: lente.to_param, lente: valid_attributes }
        expect(response).to redirect_to lente
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'edit' template" do
        lente = Lente.create! valid_attributes
        put :update, params: { id: lente.to_param, lente: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #update"

  describe "DELETE #destroy" do
    it "destroys the requested mica" do
      lente = Lente.create! valid_attributes
      expect {
        delete :destroy, params: { id: lente.to_param }
      }.to change(Lente, :count).by(-1)
    end

    it "redirects to the micas list" do
      lente = Lente.create! valid_attributes
      delete :destroy, params: { id: lente.to_param }
      expect(response).to redirect_to(lentes_url)
    end
  end # describe "DELETE #destroy"

end
