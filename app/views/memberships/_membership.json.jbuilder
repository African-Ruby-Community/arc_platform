json.extract! membership, :id, :user_id, :chapter_id, :start_date, :end_date, :created_at, :updated_at
json.url membership_url(membership, format: :json)
