require 'rails_helper'

RSpec.describe "administradores/show", type: :view do
  before(:each) do
    @administrador = assign(:administrador, Administrador.create!(
      nombre: "Nombre",
      telefono: "Telefono",
      email: "email@gmail.com",
      password: "123123123",
      password_confirmation: "123123123",
    ))
  end

  it "muestra los atributos" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/email@gmail.com/)
  end
end
