require 'rails_helper'

RSpec.describe "marcas/new", type: :view do
  before(:each) do
    assign(:marca, Marca.new(
      :nombre => "MyString",
      :descripcion => "MyString"
    ))
  end

  it "renders new marca form" do
    render

    assert_select "form[action=?][method=?]", marcas_path, "post" do

      assert_select "input[name=?]", "marca[nombre]"

      assert_select "textarea[name=?]", "marca[descripcion]"
    end
  end
end
