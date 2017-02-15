require "rails_helper"

describe User, type: :feature do
  describe "A visitor" do
    it "can register as a user with correct field inputs" do
      email = "#{(0..1000).to_a.sample}@email.com"
      phone_number = "#{(0..1000).to_a.sample(10).join[0..9]}"

      visit root_path
      click_on "Create Account"
      expect(current_path).to eq(new_user_path)

      fill_in "First Name", with: "First Name"
      fill_in "Last Name", with: "Last Name"
      fill_in "Email", with: email
      fill_in "Phone Number", with: phone_number
      fill_in "Password", with: "Password"
      fill_in "Confirm Password", with: "Password"

      click_on "Sign Up"

      user = User.last

      expect(current_path).to eq(user_path(user.id))
      expect(page).not_to have_content("Create Account")
      expect(page).to have_content("First Name")
      expect(page).to have_content("Last Name")
      expect(page).to have_content(email)
      expect(page).to have_content(phone_number)
    end

    it "cannot register as a user without correct field inputs" do
      visit root_path
      click_on "Create Account"
      expect(current_path).to eq(new_user_path)

      fill_in "First Name", with: "First Name"
      fill_in "Last Name", with: "Last Name"
      fill_in "Email", with: "Email"

      click_on "Sign Up"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Phone number can't be blank")
    end

    it "requires 2 factor authentication to register" do
      user = build(:user)
      visit root_path

      click_on "Create Account"

      fill_in "First Name", with: user.first_name
      fill_in "Last Name", with: user.last_name
      fill_in "Email", with: user.email
      fill_in "Phone Number", with: user.phone_number
      fill_in "Password", with: user.password
      fill_in "Confirm Password", with: user.password

      click_on "Sign Up"

      expect(current_path).to eq(new_confirmation_path)

      expect(page).to have_content(user.phone_number)

      fill_in "Verification Code", with: user.verification_code

      click_on "Verify"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Verified")
    end
  end
end
