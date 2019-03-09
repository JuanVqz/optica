FactoryBot.define do
  factory :vendedor do
    sequence(:nombre) { |n| "vendedor#{n}" }
    sequence(:email) { |n| "vendedor#{n}@gmail.com" }
    password { "123456" }
    cargo { 'vendedor' }
    activo { true }
    notificar { false }
  end
end
