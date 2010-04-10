require 'rubygems'
require 'haml'
require 'sinatra'
require 'flickraw'

flickr_config = if File.exists?('flickr.yml')
  YAML.load_file('flickr.yml')
else
  { 'key' => ENV['flickr_key'] }
end

get '/' do
  photos = flickr.photos.search  :api_key => flickr_config['key'],
                                 :user_id => '86448492@N00',
                                 :tags => 'everydamnedshirt',
                                 :per_page => 20,
                                 :extra_info => 'path_alias,url_sq,url_t,url_s,url_m,url_o'
  
  @photo = photos[0]
  entity_tag(@photo['id'])
                          
  @description = flickr.photos.getInfo(:photo_id => @photo['id']).description
  @photo_url = FlickRaw.url(@photo)
  @photo_link = FlickRaw.url_photopage(@photo)
  
  @other_thumbnails = photos.to_a.reverse.collect do |photo|
    [photo.title, FlickRaw.url_t(photo), FlickRaw.url_photopage(photo)]
  end
  
  haml :index
end