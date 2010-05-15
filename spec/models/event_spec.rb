require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do

  describe 'Creating an event' do
    
    before(:each) do
      @user = User.make
    end
    
    it "should validate name" do
      event = Event.new
      event.should_not be_valid
      event.name = 'testme'
      event.should be_valid
    end
    
    it "should create an activity" do
      lambda {
        Event.make(:user_id => @user.id)
      }.should change(Activity, :count).by(1)
    end
  
  end
  
  describe 'Deleting an event' do
    
    before(:each) do
      @event = Event.make
      5.times do
        Photo.make(:event_id => @event.id)
      end
    end
        
    it "should remove photos" do
      lambda {
        @event.destroy
      }.should change(Photo, :count).by(-5)
    end
    
    it "should remove activities" do
      lambda {
        @event.destroy
      }.should change(Activity, :count).by(-6)
    end
  
  end
  
  describe 'Joining an event' do
    
    before(:each) do
      @event = Event.make
      @user = User.make
    end
    
    it "should add the user to user_ids" do
      @event.user_ids.count == 0
      @event.add_user(@user)
      @event.reload
      @event.user_ids.should == [@user.id]
      @event.users.should == [@user]
    end

  end

end