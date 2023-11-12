FactoryBot.define do
  factory :rental do
    date { '2023-11-12' }
    time { '15:00:00' }
    duration { '1' }
    destination { 'Mahina' }
    association :user
    association :car
    association :chauffeur 
  end
end
