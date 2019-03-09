FactoryBot.define do
  factory :usuario do
    sequence(:nombre) { |n| "usuario#{n}" }
    sequence(:email) { |n| "usuario#{n}@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    cargo { nil }
    activo { true }
  end
end
