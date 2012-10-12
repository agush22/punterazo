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

    it "should return map info in json" do
      @field2 = FactoryGirl.create(:field, lat: "1", long: "2")
      @expected_json = "[{\"id\":#{@field.id},\"lat\":#{@field.lat},\"long\":#{@field.long},\"name\":\"#{@field.name}\"},{\"id\":#{@field2.id},\"lat\":#{@field2.lat},\"long\":#{@field2.long},\"name\":\"#{@field2.name}\"}]"
      Field.map_info_to_json.should == @expected_json
    end
end
