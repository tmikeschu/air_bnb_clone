require "rails_helper"

describe "User" do
  let!(:profile) { create(:profile)}
  let!(:user)    { profile.user}

  before do
    stub_login(user)
  end

  context "can host couches from their page" do
    it "can have choice to add couch" do
      visit user_path(user)

      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_link("Add a Couch")
    end

    it "can create a new couch" do
      VCR.use_cassette("couch_build_phillip") do
        visit user_path(user)
        click_on("Add a Couch")

        expect(current_path).to eq(new_user_couch_path(user.id))

        couch_data = build(:couch, :phillip)
        within("form") do
          %i[name description street_address city state zipcode].each do |attr|
            fill_in "couch_#{attr}", with: couch_data.send(attr)
          end
          click_on "Add Couch"
        end

        couch = Couch.last

        expect(current_path).to eq(user_couch_path(user, couch))
        expect(page).to have_link("Add Availability")
      end
    end
  end

  context "sad path" do
    it "will re route to new couch path" do
      visit user_path(user)
      click_on "Add a Couch"

      within("form") do
        fill_in "couch_name", with: "Bertha XXL"

        fill_in "couch_street_address", with: "123 IDK"
        fill_in "couch_city", with: "Some City"

        fill_in "couch_zipcode", with: "11111"
        click_on "Add Couch"
      end

      expect(current_path).to eq(new_user_couch_path(user, user.couches.new))
    end
  end
end
