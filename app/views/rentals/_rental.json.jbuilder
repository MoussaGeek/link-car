json.extract! rental, :id, :date, :time, :duration, :destination, :user_id, :car_id, :created_at, :updated_at
json.url rental_url(rental, format: :json)
