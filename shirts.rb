require 'rubygems'
require 'haml'
require 'sinatra'

# all my API code
require File.join(File.dirname(__FILE__), "utils")

get '/' do
  search = FlickrSearch.new

  @photo = search.current_photo
  etag(@photo['id'])

  @description = search.current_photo_description
  @photo_url = FlickRaw.url(@photo)
  @photo_link = FlickRaw.url_photopage(@photo)

  @other_thumbnails = search.other_thumbnails
  haml :index
end

get '/show/:photo_id' do
  search = FlickrSearch.new(params[:photo_id])

  @photo = search.current_photo
  etag(@photo['id'])

  @description = search.current_photo_description
  @photo_url = FlickRaw.url(@photo)
  @photo_link = FlickRaw.url_photopage(@photo)

  @other_thumbnails = search.other_thumbnails

  haml :index
end
