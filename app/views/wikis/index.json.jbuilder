json.array!(@wikis) do |wiki|
  json.extract! wiki, :id
  json.url wiki_url(wiki, format: :json)
end
