require 'spec_helper'

describe "Fields" do
  describe "Create Field" do
    it "Should be able to create a field without sign in" do
      visit new_field_path
      fill_in 'Name', :with => "Field X"
      click_on 'Create Field'
      Field.find_by_name("Field X").accept
      visit root_path
      page.should have_content("Field X")
    end
  end
  describe "Show rejected or pending field" do
    it "Should not be able to view a rejected or pending field" do
      @rejected_field = FactoryGirl.create(:field, :name => "Rejected")
      @pending_field = FactoryGirl.create(:field, :name => "Pending")
      @rejected_field.reject
      visit root_path
      page.should_not have_content("Rejected")
      page.should_not have_content("Pending")
    end
  end
end

