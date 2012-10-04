require 'spec_helper'

describe "Fields" do
  before (:each) do
    @field = FactoryGirl.create(:field)
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_on 'Sign in'
  end

  describe "Create Field" do
    it "Create a field and associate it to current user" do
      visit new_field_path
      fill_in 'Name', :with => "Field X"
      click_on 'Create Field'
      visit fields_user_path(@user)
      page.should have_content("Field X")
    end
  end
end
