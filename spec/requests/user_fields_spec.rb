require 'spec_helper'

describe "Fields" do
  before (:each) do
    @user = FactoryGirl.create(:user)
    @field = FactoryGirl.create(:field, :user => @user)
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
  describe "Edit Field" do
    it "Edit a field the user owns" do
      visit fields_user_path(@user)
      click_on 'Edit'
      fill_in 'Name', :with => "Edited Field"
      fill_in 'Link', :with => "editedfield.com"
    end
  end
end
