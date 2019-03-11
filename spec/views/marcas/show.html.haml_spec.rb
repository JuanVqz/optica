require 'rails_helper'

RSpec.describe "marcas/show", type: :view do
  before(:each) do
    @marca = assign(:marca, Marca.create!(
      :nombre => "Nombre",
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
  end
end
