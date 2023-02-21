json.extract! participation, :id, :stripe_customer_id, :user_id, :event_id, :created_at, :updated_at
json.url participation_url(participation, format: :json)
