require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
  end

  it { should have_many(:fields)}

  it "should return true if user is admin" do
    @admin.admin?.should == true
  end
  it "should return false if user is not admin" do
    @user.admin?.should == false
  end
end
