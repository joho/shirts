require 'rubygems'
require 'haml'
require 'sinatra'
require 'flickraw'

flickr_config = if File.exists?('flickr.yml')
  YAML.load_file('flickr.yml')
else
  { "secret" => ENV['flickr_secret'],
    "key" => ENV['flickr_key'] }
end

get '/' do
  @photo = flickr.photos.search  :api_key => flickr_config['key'],
                                :user_id => '86448492@N00',
                                # :tags => 'everydamnedshirt',
                                :per_page => 1
                                 
  @photo_info = flickr.photos.getInfo(:photo_id => @photo.first[0]['id'])
  @photo_url = FlickRaw.url(@photo_info)
  
  haml :index
end