require 'rails_helper'

RSpec.describe "empresas/index", type: :view do
  before(:each) do
    assign(:empresas, [
      Empresa.create!(
        :nombre => "Nombre",
        :rfc => "Rfc",
        :eslogan => "Eslogan",
        :logotipo => "Logotipo"
      ),
      Empresa.create!(
        :nombre => "Nombre",
        :rfc => "Rfc",
        :eslogan => "Eslogan",
        :logotipo => "Logotipo"
      )
    ])
  end

  it "renders a list of empresas" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Rfc".to_s, :count => 2
  end
end