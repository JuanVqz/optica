require 'rails_helper'

RSpec.describe "administradores/index", type: :view do

  before(:each) do
    assign(:administradores, Kaminari.paginate_array([
      Administrador.create!(
        nombre: "Nombre",
        telefono: "Telefono",
        email: "email@gmail.com",
        password: "123123123",
        password_confirmation: "123123123",
      ),
      Administrador.create!(
        nombre: "Nombre dos",
        telefono: "Telefono",
        email: "email_dos@gmail.com",
        password: "123123123",
        password_confirmation: "123123123",
      )
    ]).page(1))
  end

  it "muestra la lista de administradores" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 1
    assert_select "tr>td", :text => "admin".to_s, :count => 2
  end
end
