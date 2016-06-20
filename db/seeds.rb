client = Yelp::Client.new({
  consumer_key:ENV['CONSUMER_KEY'],
  consumer_secret:ENV['CONSUMER_SECRET'],
  token: ENV['TOKEN'],
  token_secret:ENV['TOKEN_SECRET']
})

parameters = { term: 'restaurants', limit: 5 }
sf_results = client.search('San Francisco', parameters)

sf_results.businesses.each do |b|
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city)
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant.images.create!(url: new_url)
end

chi_results = client.search('Chicago', parameters)

chi_results.businesses.each do |b|
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city)
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant.images.create!(url: new_url)
end

nyc_results = client.search('New York', parameters)

nyc_results.businesses.each do |b|
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city)
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant.images.create!(url: new_url)
end