FactoryBot.define do
  factory :chauffeur do
    name { 'John Doe' }
    quartier { 'Kondjili' }
    association :parking
    telephone { '12345678' }
  end
end
