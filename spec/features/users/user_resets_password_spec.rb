require "rails_helper"

RSpec.feature "Two Factor Authentication" do
  describe "Password reset" do
    let!(:user) { create(:user) }
    it "requires 2 factor authentication" do
      VCR.use_cassette ("2FA") do
        visit new_user_path

        click_on "Forgot Password"

        fill_in "Email", with: user.email

        expect(current_path).to eq(new_confirmation_path)

        expect(page).to have_content(user.phone_number)

        fill_in "Verification Code", with: user.verification_code

        click_on "Verify"

        expect(current_path).to eq(password_resets_path)
        expect(page).to have_content("Welcome #{user.first_name}. The Adventure Begins!")
      end
    end
  end
end
