require "rails_helper"
include ModelHelpers

describe "Traveler" do
  describe "As a registered user" do
    let!(:traveler) { create(:user) }
    let!(:profile)  { create(:profile) }
    let!(:couch_1)  { create(:couch, city: "Another City", user_id: profile.user_id) }
    let!(:couch_2)  { create(:couch, city: "Mike's Hometown") }
    let!(:today)  { Date.current }
    let!(:tomorrow)  { Date.tomorrow }
    before do
      visit root_path
      couch_1.nights << create(:night, date: today)
      couch_1.nights << create(:night, date: tomorrow)
      stub_login(traveler)
    end

    scenario "I can view available couches for a city and date range" do
      fill_in "Destination", with: couch_1.city

      fill_in "Check In", with: today.to_date_picker_format
      fill_in "Check Out", with: tomorrow.to_date_picker_format
      click_on "Find Pad"

      expect(current_path).to eq(search_path)
      expect(page).to have_content "1 couch in #{couch_1.city} available starting on #{today.to_date_picker_format}"
      expect(page).to have_content couch_1.name
      expect(page).to have_content couch_1.description
      expect(page).not_to have_content couch_2.name
    end

    scenario "I can reserve an available couch" do
      visit search_path("Destination": couch_1.city,
                        "Check In": today.to_date_picker_format,
                        "Check Out": tomorrow.to_date_picker_format)
      click_on "Reserve"

      reservation = traveler.reservations.first
      expect(page).to have_content "#{couch_1.name} reserved for #{today}."
      expect(page).to have_content "My Travel Reservations"
      expect(page).to have_content "Confirmed"
      expect(page).to have_content reservation.id
      expect(page).to have_content reservation.couch_name
      expect(page).to have_content reservation.status.capitalize
      expect(page).to have_content reservation.check_in
      expect(page).to have_content reservation.check_out
      expect(page).not_to have_content couch_2.name
    end

    scenario "I can reserve an available couch from couch listing" do
      visit couch_path(couch_1)

      fill_in "Couch_Listing_Check_In", with: today.to_date_picker_format
      fill_in "Couch_Listing_Check_Out", with: tomorrow.to_date_picker_format
      click_on "Create Reservation"

      reservation = traveler.reservations.first
      expect(page).to have_content "#{couch_1.name} reserved for #{today}."
      expect(page).to have_content "My Travel Reservations"
      expect(page).to have_content "Confirmed"
      expect(page).to have_content reservation.id
      expect(page).to have_content reservation.couch_name
      expect(page).to have_content reservation.status.capitalize
      expect(page).to have_content reservation.check_in
      expect(page).to have_content reservation.check_out
      expect(page).to have_content
      expect(page).not_to have_content couch_2.name
    end
  end
end
