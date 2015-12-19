require 'flickraw'

FlickRaw.api_key=ENV.fetch('FLICKR_KEY')
FlickRaw.shared_secret=ENV.fetch('FLICKR_SECRET')

class FlickrSearch
  def initialize(photo_id = nil)
    @photo_id = photo_id
  end

  def current_photo
    @current_photo ||= if @photo_id
      matching_photos.to_a.find { |photo| photo['id'] == @photo_id }
    else
      matching_photos[0]
    end
  end

  def current_photo_description
    flickr.photos.getInfo(:photo_id => current_photo['id']).description
  end

  def other_thumbnails
    matching_photos.to_a.reverse.collect do |photo|
      [photo.title, FlickRaw.url_t(photo), "/show/#{photo['id']}"]
    end
  end

  def matching_photos
    @matching_photos ||= flickr.photos.search(search_conditions)
  end

protected
  def search_conditions
    {
      :user_id => '86448492@N00',
      :tags => 'everydamnedshirt',
      :sort => 'date-taken-desc',
      :per_page => 500,
      :extra_info => 'path_alias,url_sq,url_t,url_s,url_m,url_o'
    }
  end
end
