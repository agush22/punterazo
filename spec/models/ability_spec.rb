require 'spec_helper'
require 'cancan/matchers'

describe "Ability" do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @field = FactoryGirl.create(:field)
  end
  describe "Admin ability" do
    it "Should be able to manage fields" do
      @admin_ability = Ability.new(@admin)
      @admin_ability.should be_able_to(:manage, @field)
    end
  end
  describe "Admin ability" do
    it "Should be able to manage fields" do
      @admin_ability = Ability.new(@admin)
      @admin_ability.should be_able_to(:manage, @field)
    end
  end
end
