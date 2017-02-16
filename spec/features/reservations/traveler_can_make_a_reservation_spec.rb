require "rails_helper"
include ModelHelpers

describe "Traveler" do
  describe "As a registered user" do
    let!(:traveler) { create(:user) }
    let!(:couch_1)  { create(:couch, street_address: "1311 17th St", city: "Denver", state: "CO", zipcode: "80123") }
    let!(:couch_2)  { create(:couch, city: "Mike's Hometown", name: "NEVER GONNA REPEAT") }
    let!(:profile)  { create(:profile) }
    let!(:today)  { Date.current }
    let!(:tomorrow)  { Date.tomorrow }


    scenario "I can view available couches for a city and date range" do
      visit root_path
      couch_1.nights << create(:night, date: today)
      couch_1.nights << create(:night, date: tomorrow)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
      couch_2.nights << create(:night, date: today)
      couch_2.nights << create(:night, date: tomorrow)
      stub_login(traveler)
    end

    scenario "I can view available couches for a city and date range" do
      fill_in "Destination", with: couch_1.city

      fill_in "Check In", with: today.to_date_picker_format
      fill_in "Check Out", with: tomorrow.to_date_picker_format
      click_on "Find Pad"

      expect(current_path).to eq(search_path)
      expect(page).to have_content "1 couch in #{couch_1.city} available from #{today.to_date_picker_format} to #{tomorrow.to_date_picker_format}"
      expect(page).to have_content couch_1.name
      expect(page).to have_content couch_1.description
      expect(page).not_to have_content couch_2.name
    end

    scenario "I can update my search for a city an date range" do 
      fill_in "Destination", with: couch_1.city

      fill_in "Check In", with: today.to_date_picker_format
      fill_in "Check Out", with: tomorrow.to_date_picker_format
      click_on "Find Pad"

      expect(current_path).to eq(search_path)
      expect(page).to have_content "1 couch in #{couch_1.city} available from #{today.to_date_picker_format} to #{tomorrow.to_date_picker_format}"
      expect(page).to have_content couch_1.name
      expect(page).to have_content couch_1.description
      expect(page).not_to have_content couch_2.name

      fill_in "Destination", with: couch_2.city
      click_on "Update Search"

      expect(current_path).to eq(search_path)
      expect(page).to have_content "1 couch in #{couch_2.city} available from #{today.to_date_picker_format} to #{tomorrow.to_date_picker_format}"
      expect(page).to have_content couch_2.name
      expect(page).to have_content couch_2.description
      expect(page).not_to have_content couch_1.name
    end


    scenario "I can visit a couch page" do
      visit search_path("Destination": couch_1.city,
                        "Check In": today.to_date_picker_format,
                        "Check Out": tomorrow.to_date_picker_format)
      first(:link, "View Couch").click

      expect(current_path).to eq couch_path(couch_1)
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

    scenario "I can reserve an available couch from couch listing" do
      visit couch_path(couch_1)

      fill_in "Couch_Listing_Check_In", with: today.to_date_picker_format
      fill_in "Couch_Listing_Check_Out", with: tomorrow.to_date_picker_format
      click_on "Create Reservation"

      reservation = traveler.reservations.first
      expect(page).to have_content "#{couch_1.name} reserved for #{today}."
      expect(page).to have_content "My Travel Reservations"
      expect(page).to have_content reservation.id
      expect(page).to have_content reservation.location
      expect(page).to have_content reservation.couch_name
      expect(page).to have_content reservation.check_in
      expect(page).to have_content reservation.check_out
      expect(page).to have_content
      expect(page).not_to have_content couch_2.name
    end
  end
end
