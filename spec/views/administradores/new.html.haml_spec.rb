require 'rails_helper'

RSpec.describe "administradores/new", type: :view do
  before(:each) do
    assign(:administrador, Administrador.new(
      nombre: "Nombre",
      telefono: "Telefono",
      email: "email@gmail.com",
      password: "123123123",
      password_confirmation: "123123123",
    ))
  end

  it "muestra el formulario de nuevo administrador" do
    render

    assert_select "form[action=?][method=?]", administradores_path, "post" do

      assert_select "input[name=?]", "administrador[nombre]"

      assert_select "input[name=?]", "administrador[telefono]"

      assert_select "input[name=?]", "administrador[email]"

      assert_select "input[name=?]", "administrador[password]"

      assert_select "input[name=?]", "administrador[password_confirmation]"
    end
  end
end
