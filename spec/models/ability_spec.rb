require 'spec_helper'
require 'cancan/matchers'

describe "Ability" do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @field = FactoryGirl.create(:field, user: @user)
  end
  describe "Admin ability" do
    it "Should be able to manage fields" do
      @ability = Ability.new(@admin)
      @ability.should be_able_to(:manage, @field)
    end
  end
  describe "User ability" do
    it "Should be able to update his own fields if pending or rejected" do
      @ability = Ability.new(@user)
      @ability.should be_able_to(:update, @field)
    end
  end
  describe "User ability" do
    it "Should not be able to update his own fields if accepted" do
      @ability = Ability.new(@user)
      @field.accept
      @ability.should_not be_able_to(:update, @field)
    end
  end
  describe "nil ability" do
    it "Should be able to view accepted fields" do
      @ability = Ability.new(nil)
      @ability.should be_able_to(:accepted, @field)
    end
  end
  describe "nil ability" do
    it "Should be able to view fields" do
      @ability = Ability.new(nil)
      @ability.should be_able_to(:show, @field)
    end
  end
  describe "nil ability" do
    it "Should be able to create fields" do
      @ability = Ability.new(nil)
      @ability.should be_able_to(:create, @field)
    end
  end
  describe "nil ability" do
    it "Should not be able to edit fields" do
      @ability = Ability.new(nil)
      @ability.should_not be_able_to(:update, @field)
    end
  end
  describe "nil ability" do
    it "Should not be able to view fields index" do
      @ability = Ability.new(nil)
      @ability.should_not be_able_to(:index, @field)
    end
  end
  describe "nil ability" do
    it "Should not be able to view rejected fields" do
      @ability = Ability.new(nil)
      @ability.should_not be_able_to(:rejected, @field)
    end
  end

end
