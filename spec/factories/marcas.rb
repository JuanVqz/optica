FactoryBot.define do
  factory :marca do
    sequence(:nombre) { |n| "MyString#{n}" }
    descripcion { "MyString" }
  end
end
