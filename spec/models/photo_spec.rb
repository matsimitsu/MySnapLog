require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do

  describe 'Creating a photo' do
    
    it "should create an activity" do
      lambda {
        Photo.make
      }.should change(Activity, :count).by(2)
    end
  
  end
  
  describe 'Deleting a photo' do
    
    before(:each) do
      @photo = Photo.make
      5.times do
        View.make(:photo_id => @photo.id)
      end
    end
        
    it "should remove comments" do
      lambda {
        @photo.destroy
      }.should change(View, :count).by(-5)
    end
    
  end
  
end