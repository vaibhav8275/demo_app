json.extract! message, :id, :message, :message_detail, :sent_by_id, :recieved_by_id, :created_at, :updated_at
json.url message_url(message, format: :json)
