require 'rails_helper'

RSpec.describe "marcas/index", type: :view do
  before(:each) do
    assign(:marcas, Kaminari.paginate_array([
      Marca.create!(
        :nombre => "Nombre uno",
        :descripcion => "Descripcion"
      ),
      Marca.create!(
        :nombre => "Nombre",
        :descripcion => "Descripcion"
      )
    ]).page(1))
  end

  it "renders a list of marcas" do
    render
    assert_select "tr>td", :text => "Nombre uno".to_s, :count => 1
    assert_select "tr>td", :text => "Nombre".to_s, :count => 1
  end
end
