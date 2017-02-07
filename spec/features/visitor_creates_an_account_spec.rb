require "rails_helper"

describe Feature do 
  describe "A visitor" do 
    it "can register as a user" do 
      # when I visit the homepage
      visit root_path
      # and I click 'Create Account'
      click_on "Create Account"
      # and I fill out my information (see user model requirements) 
      # and I create and confirm a password (two rows)
      # and I click 'Create Account'
      click_on "Create Account"

      # then I should be on my account page
      expect(page).to eq user_dashboard
      # and I should not see a link to 'Create Account'
      expect(page).not_to have_content("Create Account")
      # and I should see my information
      expect(page).to have_content("Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Phone")
    end
  end
end