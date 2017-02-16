require 'rails_helper'
include ModelHelpers


RSpec.feature "Profiles" do
  describe "As a Registered Traveler " do
    let!(:traveler) { create(:user) }
    let!(:profile)  { create(:profile) }
    let!(:couch)    { create(:couch, user_id: profile.user_id) }
    let!(:today)    { Date.current }
    let!(:tomorrow) { Date.current + 1.day }
    before do
      visit root_path
      couch.nights << create(:night, date: today)
      couch.nights << create(:night, date: tomorrow)
      stub_login(traveler)
    end

    scenario "I can view a host's profile when searching couches" do
      visit search_path("Destination": couch.city,
                        "Check In": today.to_date_picker_format,
                        "Check Out": tomorrow.to_date_picker_format)

      expect(current_path).to eq(search_path)
      expect(page).to have_content("1 couch in #{couch.city} available")

      click_link("View Couch")

      click_link("#{profile.user.first_name}")

      expect(page).to have_content(profile.description)
    end
  end
end
