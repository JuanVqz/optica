require "rails_helper"

RSpec.describe VentasMailer, type: :mailer do

  let(:tienda) do
    create :tienda, nombre: "Optica", pagina_web: "http://optica.com"
  end
  let(:admin) do
    create :administrador, nombre: "Kenia",
      email: "kenia@gmail.com", notificar: true
  end
  let(:venta) { create :venta, :con_dos_armazones }
  let(:mail) { described_class.nueva(venta).deliver }

  before :each do
    admin
    allow_any_instance_of(TiendasHelper).to receive(:tienda_actual).and_return(tienda)
    allow(mail).to receive(:from).and_return(["notificaciones@optica.com"])
  end

  it "debe tener un enlace a la tienda" do
    expect(mail.body.encoded).to match(tienda.pagina_web)
  end

  it "debe mostrar el nombre de la tienda" do
    expect(mail.body.encoded).to match(tienda.nombre)
  end

  it "el remitente debe ser 'notificaciones@optica.com'" do
    expect(mail.from).to eq(["notificaciones@optica.com"])
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

  context "#nueva" do
    it "debe mostrar el asunto 'Kenia, se realizó una nueva venta'" do
      expect(mail.subject).to eq "Kenia, se realizó una nueva venta"
    end
  end # context #nueva

  context "#descontar_productos" do
    let(:mail) { described_class.descontar_productos(venta).deliver }

    it "debe mostrar el asunto 'Kenia, se descontó producto del inventario'" do
      expect(mail.subject).to eq "Kenia, se descontó producto del inventario"
    end
  end # context #descontar_productos

end
