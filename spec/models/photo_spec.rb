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
  
  describe "Liking a photo" do
    
    before(:each) do
      @photo = Photo.make
    end
        
    it "should raise the likes count by one and include the hash" do
      hash = Digest::SHA1.hexdigest(Faker::Name.name)
      @photo.like(hash)
      
      @photo.reload
      
      @photo.likes.should == 1
      @photo.likers.should include(hash)
    end
    
  end
  
  describe "Comments" do
    
    before(:each) do
      @photo = Photo.make
      
    end
        
    it "should create a new comment" do
      comment = Comment.make
      @photo.create_comment(comment)
      
      @photo.reload
      
      @photo.comments.count.should == 1
      @photo.comments.should include(comment)
    end
    
    it "should create an activity" do
      comment = Comment.make
      lambda {
        @photo.create_comment(comment)
      }.should change(Activity, :count).by(1)
    end
    
    it "should delete a comment" do
      comment = Comment.make
      @photo.create_comment(comment)
      
      @photo.reload
      @photo.comments.should include(comment)

      @photo.delete_comment(@photo.comments.first.id)
      @photo.reload
      
      @photo.comments.count.should == 0
      @photo.comments.should_not include(comment)
      
    end
    
    
  end
  
  
end