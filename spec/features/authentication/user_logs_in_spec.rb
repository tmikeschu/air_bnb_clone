require 'rails_helper'

describe User, type: :feature do
  describe "As a registered user" do 
    it "I can login" do 
      user = create(:user)

      visit root_path
      click_on "Log In"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Login"

      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.phone_number)
      expect(page).to have_content("Sign Out")
      expect(page).not_to have_content("Log In")
      expect(page).not_to have_content("Create Account")

    end

    it "Sad Path" do 
      user = create(:user)
      visit root_path
      click_on "Log In"

      fill_in "Email", with: user.email
      fill_in "Password", with: "wrongpassword"
      click_on "Login"

      expect(page).not_to have_content("Sign Out")
      expect(page).to have_content("Log In")
      expect(page).to have_content("Unsuccessful login attempt")
    end

    it "I can logout" do 
      user = create(:user)
      
      visit root_path
      click_on "Log In"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Login"

      expect(page).to have_content("Sign Out")
      expect(page).not_to have_content("Log In")

      click_on "Sign Out"

      expect(page).to have_content("Log In")
      expect(page).to have_content("Create Account")
      expect(page).not_to have_content("Sign Out")
    end
  end
end