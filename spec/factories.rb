FactoryGirl.define do

  factory :field do
    name "Real Canchas"
    address "Direccion x"
    city "Ciudad x"
    state "Estado x"
    country "Pais x"
    street "Calle x"
    field_type
  end

  factory :field_type do
    name "Fut 7"
  end

  factory :admin, class: User do
    sequence(:email) {|n| "admin#{n}@puraoferta.com" }
    password "admin1"
    password_confirmation "admin1"
    admin true
  end

  factory :user do
    sequence(:email) {|n| "test#{n}@puraoferta.com" }
    password "prueba"
    password_confirmation "prueba"
  end
end
