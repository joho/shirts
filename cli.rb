require 'json'

# all my API code
require File.join(File.dirname(__FILE__), "utils")

search = FlickrSearch.new

photos = search.matching_photos

File.open('photos/metadata.json', 'w') do |f|
  f.write(photos.map(&:to_hash).to_json)
end

photos.each do |photo|
  url = FlickRaw.url(photo)
  puts url
  `cd photos && wget #{url}`
end
