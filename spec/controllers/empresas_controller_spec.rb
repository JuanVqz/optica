require 'rails_helper'

RSpec.describe EmpresasController, type: :controller do

  let(:administrador) { create :administrador }
  let(:domicilio) { attributes_for :domicilio }
  let(:valid_attributes) { attributes_for :empresa, domicilio_attributes: domicilio }
  let(:invalid_attributes) { attributes_for :empresa, nombre: nil }

  before :each do
    sign_in administrador
  end

  describe "GET #index" do
    it "debe regresar una respuesta exitosa" do
      Empresa.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "debe regresar una respuesta exitosa" do
      empresa = Empresa.create! valid_attributes
      get :show, params: {id: empresa.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "debe regresar una respuesta exitosa" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "debe regresar una respuesta exitosa" do
      empresa = Empresa.create! valid_attributes
      get :edit, params: {id: empresa.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "con atributos validos" do
      it "debe crear una nueva Empresa" do
        expect {
          post :create, params: {empresa: valid_attributes}
        }.to change(Empresa, :count).by(1)
      end

      it "debe crear un nuevo Domicilio" do
        expect {
          post :create, params: {empresa: valid_attributes}
        }.to change(Domicilio, :count).by(1)
      end

      it "redirige a la empresa creada" do
        post :create, params: {empresa: valid_attributes}
        expect(response).to redirect_to(Empresa.last)
      end
    end

    context "con atributos invalidos" do
      it "debe mostrar la vista new" do
        post :create, params: {empresa: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "con atributos validos" do
      let(:new_attributes) { { nombre: "nuevo nombre" } }

      it "actualiza la empresa solicitada" do
        empresa = Empresa.create! valid_attributes
        put :update, params: {id: empresa.to_param, empresa: new_attributes}
        empresa.reload
        expect(empresa.nombre).to eq "nuevo nombre"
      end

      it "redirige a la empresa editada" do
        empresa = Empresa.create! valid_attributes
        put :update, params: {id: empresa.to_param, empresa: valid_attributes}
        expect(response).to redirect_to(empresa)
      end
    end

    context "con atributos invalidos" do
      it "debe mostrar la vista edit" do
        empresa = Empresa.create! valid_attributes
        put :update, params: {id: empresa.to_param, empresa: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "debe eliminar la empresa solicitada" do
      empresa = Empresa.create! valid_attributes
      expect {
        delete :destroy, params: {id: empresa.to_param}
      }.to change(Empresa, :count).by(-1)
    end

    it "debe mostrar la lista de empresas" do
      empresa = Empresa.create! valid_attributes
      delete :destroy, params: {id: empresa.to_param}
      expect(response).to redirect_to(empresas_url)
    end
  end

end
