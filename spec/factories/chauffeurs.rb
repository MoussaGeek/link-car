FactoryBot.define do
  factory :chauffeur do
    name { 'John' }
    quartier { 'Kondjili' }
    association :parking
    telephone { '12345678' }

    transient do
      image_path1 { Rails.root.join('spec', 'fixtures', 'permis.jpg') }
      image_path2 { Rails.root.join('spec', 'fixtures', 'carte.jpg') }
    end

    after(:build) do |chauffeur, evaluator|
      chauffeur.photo_permis.attach(
        io: File.open(evaluator.image_path1),
        filename: 'permis.jpg',
        content_type: 'image/jpeg'
      )

      chauffeur.photo_carte.attach(
        io: File.open(evaluator.image_path2),
        filename: 'carte.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end