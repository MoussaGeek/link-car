FactoryBot.define do
  factory :car do
    numero_matricule { "QR7823MD1" }
    marque { 'V8' }
    price_rental { 25000 }
    modele { 'Renault' }
    car_type { 'Voiture' }
    carburant { 'Gasoil' }
    annee { 2003 }
    disponible { true }
    association :parking

    transient do
      image_path { Rails.root.join('spec', 'fixtures', 'test_image.jpg') }
    end

    after(:build) do |car, evaluator|
      car.photo.attach(
        io: File.open(evaluator.image_path),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end