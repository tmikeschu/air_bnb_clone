require "rails_helper"

describe Feature do 
  describe "A visitor" do 
    it "can register as a user with correct field inputs" do 
      # when I visit the homepage
      visit root_path
      # and I click 'Create Account'
      click_on "Create Account"
      expect(current_path).to eq(new_session_path)
      # and I fill out my information (see user model requirements) 
      fill_in "First Name", with: "First Name"
      fill_in "Second Name", with: "Second Name"
      fill_in "Email", with: "Email"
      fill_in "Phone", with: "Phone"
      fill_in "Password", with: "Password"
      # and I create and confirm a password (two rows)
      # and I click 'Create Account'
      click_on "Create Account"

      # then I should be on my account page
      expect(page).to eq user_dashboard
      # and I should not see a link to 'Create Account'
      expect(page).not_to have_content("Create Account")
      # and I should see my information
      expect(page).to have_content("First Name")
      expect(page).to have_content("Second Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Phone")
    end

    it "cannot register as a user without correct field inputs" do 
      visit root_path
      click_on "Create Account" 
      expect(current_path).to eq(new_session_path)
    end
  end
end