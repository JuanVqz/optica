class Tienda < Empresa
  validates :logotipo, :pagina_web, presence: true
end
