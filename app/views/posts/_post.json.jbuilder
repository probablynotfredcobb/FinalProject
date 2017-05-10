json.extract! post, :id, :title, :description, :picture, :location, :tag, :price, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
