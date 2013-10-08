require 'rest-client'
require 'nokogiri'
require 'addressable/uri'
require 'json'

location = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/geocode/json",
:query_values => { :address => "1061 Market St, San Francisco, CA",
                   :sensor => false }
).to_s

response = RestClient.get(location)
json_location = JSON.parse(response)

coordinates = json_location["results"].first["geometry"]["location"].values.join(',')
# p coordinates

vendors = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/place/nearbysearch/json",
:query_values => {
                  :key => "AIzaSyBtJztsbe5z93ePYrVxj379h8OTvUf520c",
                  :location => "#{coordinates}",
                  :radius => 300,
                  :keyword => "ice cream",
                  :sensor => false,
                  :opennow => true
                 },
).to_s

p vendors
# response = RestClient.get(vendors)
# json_vendors = JSON.parse(response)
# p json_vendors




# puts RestClient.get()
