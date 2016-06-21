client = Yelp::Client.new({
  consumer_key:ENV['CONSUMER_KEY'],
  consumer_secret:ENV['CONSUMER_SECRET'],
  token: ENV['TOKEN'],
  token_secret:ENV['TOKEN_SECRET']
})

parameters = { term: 'restaurants', limit: 9 }
sf_results = client.search('San Francisco', parameters)

sf_results.businesses.each do |b|
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city, address: b.location.address[0], image_url: new_url, phone_number: b.phone)
  10.times do
    current_restaurant.tables.create!(capacity: [2,4,8].sample)
  end
end

chi_results = client.search('Chicago', parameters)

chi_results.businesses.each do |b|
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city, address: b.location.address[0], image_url: new_url, phone_number: b.phone)
  10.times do
    current_restaurant.tables.create!(capacity: [2,4,8].sample)
  end
end

nyc_results = client.search('New York', parameters)

nyc_results.businesses.each do |b|
  url = b.image_url
  url_after_last_slash = url.split('/')[-1]
  url_after_last_slash_length = url_after_last_slash.length
  new_url = url[0..(url.length-url_after_last_slash_length-1)] + "l.jpg"
  current_restaurant = Restaurant.create!(name: b.name, city: b.location.city, address: b.location.address[0], image_url: new_url, phone_number: b.phone)
  10.times do
    current_restaurant.tables.create!(capacity: [2,4,8].sample)
  end
end