require 'rails_helper'

RSpec.describe Tienda, type: :model do
  it { should validate_presence_of :logotipo }
  it { should validate_presence_of :pagina_web }
end
