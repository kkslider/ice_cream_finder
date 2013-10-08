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
)

puts location.to_s


vendors = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "maps/api/place/nearbysearch",
:output => "json",
:query_values => {:location => "value" },
)
# puts RestClient.get()
#
