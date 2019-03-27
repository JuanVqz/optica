FactoryBot.define do
  factory :tienda do
    nombre { "MyString" }
    telefono { "MyString" }
    rfc { "MyString" }
    eslogan { "MyString" }
    pagina_web { "MyString" }
    leyenda_boleto { "MyString" }
    logotipo {
      FactoryBotHelpers.subir_archivo(nombre: 'opticajj.jpg', formato: 'jpg')
    }
  end
end
