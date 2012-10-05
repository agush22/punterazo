require 'spec_helper'

describe "SignIns" do
  describe "User Sign In" do
    it "should sign in a user" do
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_on "Sign in"
      page.should have_content('Logout')
    end
  end
  describe "Admin Sign In" do
    it "should sign in a admin" do
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_on "Sign in"
      page.should have_content('Logout')
    end
  end
end
