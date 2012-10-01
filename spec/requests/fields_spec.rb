require 'spec_helper'

describe "Fields" do
  before (:each) do
    @field = FactoryGirl.create(:field)
    @admin = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', :with => @admin.email
    fill_in 'Password', :with => @admin.password
    click_on 'Sign in'
  end

  describe "Accept Field" do
    it "should accept field in pending fields" do
      visit pending_fields_path
      click_on 'Accept'
      click_on 'Back'
      visit accepted_fields_path
      page.should have_content(@field.name)
    end
  end

  describe "Reset Field" do
    it "should reset field and return it to pending" do
      @field.accept
      visit accepted_fields_path
      click_on 'Reset'
      visit pending_fields_path
      page.should have_content(@field.name)
    end
  end

  describe "Reject Field" do
    it "should reject field in pending fields" do
      visit pending_fields_path
      click_on 'Reject'
      visit rejected_fields_path
      page.should have_content(@field.name)
    end
  end
end
