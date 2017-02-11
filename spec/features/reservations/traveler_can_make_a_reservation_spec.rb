=begin
As a traveler
when I visit the homepage
and I enter a location and dates for a trip
and I click 'Find a Couch'
and I click 'Reserve' on the first couch
then I see a confirmation message (flash)
then I am taken to a list of my travel reservations
and I see a link to that reservation couch listing
=end

require "rails_helper"

describe "Traveler" do
  describe "As a registered user" do
    let!(:traveler) { create(:user) }
    let!(:couch_1)  { create(:couch, city: "Another City") }
    let!(:couch_2)  { create(:couch, city: "Mike's Hometown") }
    let!(:today)  { Date.current }
    let!(:tomorrow)  { Date.tomorrow }
    before do 
      visit root_path
      couch_1.nights << create(:night, date: today)
      couch_1.nights << create(:night, date: tomorrow)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
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

    scenario "I can reserve an available couch from homepage search" do
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

    scenario "I can reserve an available couch from couch listing" do       
      # when I visit the page for a couch listing
      visit couch_path(couch_1)
      # and I select reservation dates
      click_on today
      # and I click 'Reserve'
      click_on "Reserve"
      # then I am taken to my traveler reservations page
      # and I see a link to that listing.
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
