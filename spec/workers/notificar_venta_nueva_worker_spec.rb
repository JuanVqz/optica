require 'rails_helper'

RSpec.describe NotificarVentaNuevaWorker, type: :worker do
  subject { described_class }

  context "cuando se realiza una nueva venta" do
    let(:venta) { create :venta }

    it "se debe ejecutar una vez" do
      expect {
        subject.perform_async(venta.id)
      }.to change(subject.jobs, :size).by(1)
    end
  end # context cuando se realiza una nueva venta

end
