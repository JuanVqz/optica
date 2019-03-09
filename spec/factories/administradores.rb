FactoryBot.define do
  factory :administrador do
    sequence(:nombre) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    cargo { 'admin' }
    activo { true }
    notificar { false }
  end
end
