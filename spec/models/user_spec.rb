require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  describe 'Creating an user' do
    
    before(:each) do
      @user = User.make
    end
    
    it "should validate" do
      user = User.new
      user.should_not be_valid
    end
    
  end
  
  describe 'Deleting an user' do
    
    before(:each) do
      @user = User.make
      5.times do
        Photo.make(:user_id => @user.id)
      end
      @event = Event.make(:manager_id => @user.id)
    end
        
    it "should remove photos" do
      lambda {
        @user.destroy
      }.should change(Photo, :count).by(-5)
    end
    
    it "should remove activities" do
      lambda {
        @user.destroy
      }.should change(Activity, :count).by(-6)
    end
    
    it "should remove managed events" do
      lambda {
        @user.destroy
      }.should change(Event, :count).by(-1)
    end
  
  end
  
end