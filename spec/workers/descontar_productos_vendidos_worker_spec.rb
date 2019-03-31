require 'rails_helper'

RSpec.describe DescontarProductosVendidosWorker, type: :worker do
  subject { described_class }

  context "cuando la venta es saldada" do
    let(:venta) { create :venta, saldada: true }

    it "se debe ejecutar una vez" do
      expect {
        subject.perform_async(venta.id)
      }.to change(subject.jobs, :size).by(1)
    end
  end # context cuando la venta es saldada

end
