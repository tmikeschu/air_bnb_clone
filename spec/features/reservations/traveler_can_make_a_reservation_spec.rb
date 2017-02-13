require "rails_helper"

describe "Traveler" do
  describe "As a registered user" do
    let!(:traveler) { create(:user) }
    let!(:couch_1)  { create(:couch, city: "Another City") }
    let!(:couch_2)  { create(:couch, city: "Mike's Hometown", name: "NEVER GONNA REPEAT") }
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
      fill_in "Check In", with: today
      fill_in "Check Out", with: tomorrow
      click_on "Find Pad"

      expect(current_path).to eq(search_path)
      expect(page).to have_content "1 couch in #{couch_1.city} available starting on #{today}"
      expect(page).to have_content couch_1.name
      expect(page).to have_content couch_1.description
      expect(page).not_to have_content couch_2.name
    end

    scenario "I can reserve an available couch" do
      visit search_path("Destination": couch_1.city, "Check In": today, "Check Out": tomorrow)
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
  end
end
