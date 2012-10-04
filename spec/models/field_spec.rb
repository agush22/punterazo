require 'spec_helper'

describe Field do
    before do
      @field = FactoryGirl.create(:field)
    end

    it { should belong_to(:field_type) }
    it { should belong_to(:user)}

    it "should start with pending status" do
      @field.status.should == "pending"
    end

    it "should change status to accepted" do
      @field.accept
      @field.status.should == "accepted"
    end

    it "should change status to rejected" do
      @field.reject
      @field.status.should == "rejected"
    end

    it "should reset status to pending" do
      @field.reset
      @field.status.should == "pending"
    end
end
