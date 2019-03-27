require 'rails_helper'

RSpec.describe VentasController, type: :controller do

  let(:vendedor) { create :vendedor }
  let(:cliente) { create :cliente }
  let(:pago) { attributes_for :pago, efectivo: 300, anticipo: 290, cambio: 10 }

  let(:lente) { create :lente, precio_venta: 100, usuario: vendedor }
  let(:mica) { create :mica, precio_venta: 200, usuario: vendedor }
  let(:vendidos) do
    [
      {
        producto_id: lente.id, cantidad: 1, precio_compra: lente.precio_compra,
        precio_venta: lente.precio_venta, descuento: 0, subtotal: 100
      },
      {
        producto_id: mica.id, cantidad: 1, precio_compra: mica.precio_compra,
        precio_venta: mica.precio_venta, descuento: 10, subtotal: 200
      }
    ]
  end

  let(:valid_attributes) do
    {
      observaciones: 'observaciones',
      saldada: true,
      facturar: true,
      fecha_entrega: Time.now,
      descuento: 10,
      total: 290,
      forma_de_pago: '01',
      pagos_attributes: [pago],
      usuario_id: vendedor.id,
      cliente_id: cliente.id,
      vendidos_attributes: vendidos
    }
  end

  let(:invalid_attributes) { attributes_for :venta, total: nil }

  before { sign_in vendedor }

  describe "GET #index" do
    it "returns a success response" do
      Venta.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end # describe "GET #new"

  describe "GET #show" do
    it "returns a success response" do
      venta = Venta.create! valid_attributes
      get :show, params: { id: venta.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #show"

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end # describe "GET #show"

  describe "GET #edit" do
    it "returns a success response" do
      venta = Venta.create! valid_attributes
      get :edit, params: { id: venta.to_param }
      expect(response).to be_successful
    end
  end # describe "GET #edit"

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Venta" do
        expect {
          post :create, params: { venta: valid_attributes }
        }.to change(Venta, :count).by(1)
      end

      it "crea un nuevo pago" do
        expect {
          post :create, params: { venta: valid_attributes }
        }.to change(Pago, :count).by(1)
      end

      it "creates two new Vendido" do
        expect {
          post :create, params: { venta: valid_attributes }
        }.to change(Vendido, :count).by(2)
      end

      it "redirects to the created venta" do
        post :create, params: { venta: valid_attributes }
        expect(response).to redirect_to Venta.last
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'new' template" do
        post :create, params: { venta: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "POST #create"

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          observaciones: 'nuevo',
          saldada: true,
          fecha_entrega: Time.now,
          descuento: 10,
          total: 290,
          usuario_id: vendedor.id
        }
      end

      it "updates the requested venta" do
        venta = Venta.create! valid_attributes
        put :update, params: { id: venta.to_param, venta: new_attributes }
        venta.reload
        expect(venta.observaciones).to eq 'nuevo'
      end

      it "redirects to the venta" do
        venta = Venta.create! valid_attributes
        put :update, params: { id: venta.to_param, venta: new_attributes }
        expect(response).to redirect_to venta
      end
    end # context with valid params

    context "with invalid params" do
      it "displays the 'edit' template" do
        venta = Venta.create! valid_attributes
        put :update, params: { id: venta.to_param, venta: invalid_attributes }
        expect(response).to be_successful
      end
    end # context with invalid params
  end # describe "PUT #update"

  describe "DELETE #destroy" do
    it "destroys the requested venta" do
      venta = Venta.create! valid_attributes
      expect {
        delete :destroy, params: { id: venta.to_param }
      }.to change(Venta, :count).by(-1)
    end

    it "redirects to the ventas list" do
      venta = Venta.create! valid_attributes
      delete :destroy, params: { id: venta.to_param }
      expect(response).to redirect_to ventas_url
    end
  end # describe "DELETE #destroy"

end
