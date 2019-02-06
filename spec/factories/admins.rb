FactoryBot.define do
  factory :admin do
    sequence(:nombre) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@gmail.com" }
    password { "123456" }
    cargo { 'admin' }
    activo { true }
  end
end
