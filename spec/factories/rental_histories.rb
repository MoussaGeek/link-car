FactoryBot.define do
  factory :rental_history do
    name { "MyString" }
    date { "2023-10-24 05:24:36" }
    time { "2023-10-24 05:24:36" }
    price { "9.99" }
    duration { 1 }
    destination { "MyString" }
    car_matricule { "MyString" }
    chauffeur { "MyString" }
    user { nil }
  end
end
