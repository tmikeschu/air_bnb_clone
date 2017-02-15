require "rails_helper"

RSpec.feature "Two Factor Authentication" do
  describe "Password reset" do
    let!(:user) { create(:user) }
    xit "requires 2 factor authentication" do
      VCR.use_cassette ("2FA") do
        visit new_user_path

        click_on "Forgot Password"

        expect(current_path).to eq(new_password_reset_path)

        fill_in "Email", with: user.email
        click_on "Find Account"

        expect(current_path).to eq(new_confirmation_path)

        fill_in "Verification Code", with: user.verification_code
        fill_in "Email", with: user.email

        click_on "Verify"
save_and_open_page
        expect(current_path).to eq(edit_password_reset_path(user))
        expect(page).to have_content("Welcome #{user.first_name}. The Adventure Begins!")
      end
    end
  end
end
