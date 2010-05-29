module FlickrImporter
  class Importer
    
    def self.set(user, event, set_id)
      flickr_user = Fleakr.user_for_token(user.flickr_token)
      flickr_set = flickr_user.sets.select { |st| st.id == set_id }.first
      flickr_set.photos.each do |photo|
        event.photos.create(:remote_image_url => photo.original.url, :user_id => user.id, :source => 'flickr', :safe => true)
      end
    end
  end
end