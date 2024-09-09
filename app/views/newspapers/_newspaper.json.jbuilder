json.extract! newspaper, :id, :name, :url, :language, :created_at, :updated_at
json.url newspaper_url(newspaper, format: :json)
