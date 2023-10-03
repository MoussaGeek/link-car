json.extract! car, :id, :numero_matricule, :marque, :modele, :car_type, :annee, :price_rental, :carburant, :disponible, :parking_id, :created_at, :updated_at
json.url car_url(car, format: :json)
