require 'rest-client'
require 'nokogiri'
require 'addressable/uri'
require 'json'

puts "Enter your current location:"
address = gets.chomp

location = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/geocode/json",
:query_values => {
                   :address => "#{address}",
                   :sensor => false
                 }
).to_s

response = RestClient.get(location)
json_location = JSON.parse(response)

my_coordinates = json_location["results"].first["geometry"]["location"].values.join(',')


vendors = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/place/nearbysearch/json",
:query_values => {
                  :key => "AIzaSyBtJztsbe5z93ePYrVxj379h8OTvUf520c",
                  :location => "#{my_coordinates}",
                  :radius => 1300,
                  :keyword => "ice cream",
                  :sensor => false,
                  :opennow => true
                 }
).to_s


response = RestClient.get(vendors)
json_vendors = JSON.parse(response)

ic_coordinates = json_vendors["results"].first["geometry"]["location"].values.join(',')

directions = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/directions/json",
:query_values => {
                  :origin => "#{my_coordinates}",
                  :destination => "#{ic_coordinates}",
                  :sensor => false,
                  :mode => "walking"
                 }
).to_s

response = RestClient.get(directions)
json_directions = JSON.parse(response)

p directions

json_directions["routes"].first["legs"].first["steps"].each do |direction|
  parsed_direction = Nokogiri::HTML(direction["html_instructions"])

  if parsed_direction.text.include?("Destination")
    split_directions = parsed_direction.text.split("Destination")
    puts split_directions.first
    puts "Destination" + split_directions.last
  else
    puts parsed_direction.text
  end
end


