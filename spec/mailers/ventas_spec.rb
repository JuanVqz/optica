require "rails_helper"

RSpec.describe VentasMailer, type: :mailer do

  context "#nueva" do
    let!(:admin) do
      create :administrador, nombre: "Kenia",
        email: "kenia@gmail.com", notificar: true
    end

    let(:venta) { create :venta, :con_dos_armazones }
    let(:mail) { described_class.nueva(venta).deliver }

    it "debe mostrar el asunto 'Kenia, se realizó una nueva venta'" do
      expect(mail.subject).to eq "Kenia, se realizó una nueva venta"
    end

    it "el destinatario debe ser 'kenia@gmail.com'" do
      expect(mail.to).to eq(["kenia@gmail.com"])
    end

    it "el cuerpo debe tener el nombre del administrador" do
      expect(mail.body.encoded).to match(/Kenia/)
    end

    it "debe tener un boton al detalle de la venta" do
      expect(mail.body.encoded).to match("Click para el detalle de venta")
    end
  end # context #nueva

end
