require "rails_helper"

describe User, type: :feature do 
  describe "A visitor" do 
    it "can register as a user with correct field inputs" do 
      # when I visit the homepage
      visit root_path
      # and I click 'Create Account'
      click_on "Create Account"
      expect(current_path).to eq(new_user_path)
      # and I fill out my information (see user model requirements) 
      fill_in "First name", with: "First Name"
      fill_in "Last name", with: "Last Name"
      fill_in "Email", with: "Email"
      fill_in "Phone number", with: "Phone"
      fill_in "Password", with: "Password"
      # and I create and confirm a password (two rows)
      # and I click 'Create Account'
      click_on "Sign Up"

      # then I should be on my account page
      # expect(page).to eq user_path(1)
      # and I should not see a link to 'Create Account'
      expect(page).not_to have_content("Create Account")
      # and I should see my information
      expect(page).to have_content("First Name")
      expect(page).to have_content("Last Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Phone")
    end

    it "cannot register as a user without correct field inputs" do 
      visit root_path
      click_on "Create Account" 
      expect(current_path).to eq(new_user_path)

      fill_in "First name", with: "First Name"
      fill_in "Last name", with: "Last Name"
      fill_in "Email", with: "Email"

      click_on "Sign Up"
      
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("you done fucked up")
    end
  end
end