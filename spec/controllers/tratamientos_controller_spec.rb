require 'rails_helper'

RSpec.describe TratamientosController, type: :controller do

  let(:vendedor) { create :vendedor }
  let(:marca) { create :marca }

  let(:valid_attributes) do
    attributes_for :tratamiento, usuario_id: vendedor.id, marca_id: marca.id
  end
  let(:invalid_attributes) { attributes_for :tratamiento, nombre: nil }

  before { sign_in vendedor }

  describe "GET #index" do
    it "returns a success response" do
      Tratamiento.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #show" do
    it "returns a success response" do
      tratamiento = Tratamiento.create! valid_attributes
      get :show, params: { id: tratamiento.to_param }
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
      tratamiento = Tratamiento.create! valid_attributes
      get :edit, params: { id: tratamiento.to_param}
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Mica" do
        expect {
          post :create, params: { tratamiento: valid_attributes }
        }.to change(Tratamiento, :count).by(1)
      end

      it "redirects to the created mica" do
        post :create, params: { tratamiento: valid_attributes }
        expect(response).to redirect_to Tratamiento.last
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'new' template" do
        post :create, params: { tratamiento: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #create"

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nombre: 'nuevo' }
      end

      it "updates the requested mica" do
        tratamiento = Tratamiento.create! valid_attributes
        put :update, params: { id: tratamiento.to_param, tratamiento: new_attributes }
        tratamiento.reload
        expect(tratamiento.nombre).to eq 'nuevo'
      end

      it "redirects to the mica" do
        tratamiento = Tratamiento.create! valid_attributes
        put :update, params: { id: tratamiento.to_param, tratamiento: valid_attributes }
        expect(response).to redirect_to(tratamiento)
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'edit' template" do
        tratamiento = Tratamiento.create! valid_attributes
        put :update, params: { id: tratamiento.to_param, tratamiento: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #update"

  describe "DELETE #destroy" do
    it "destroys the requested mica" do
      tratamiento = Tratamiento.create! valid_attributes
      expect {
        delete :destroy, params: { id: tratamiento.to_param }
      }.to change(Tratamiento, :count).by(-1)
    end

    it "redirects to the micas list" do
      tratamiento = Tratamiento.create! valid_attributes
      delete :destroy, params: { id: tratamiento.to_param }
      expect(response).to redirect_to(tratamiento_url)
    end
  end # describe "DELETE #destroy"

end
