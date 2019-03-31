FactoryBot.define do
  factory :super_usuario do
    sequence(:nombre) { |n| "super_usuario#{n}" }
    sequence(:email) { |n| "super_usuario#{n}@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    cargo { 'superusuario' }
    activo { true }
    notificar { false }
  end
end
