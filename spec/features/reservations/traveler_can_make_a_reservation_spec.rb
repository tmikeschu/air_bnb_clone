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
    it "I can reserve a couch starting from the homepage" do
      traveler = create(:user)
      couch = create(:couch)
      city = couch.city
      date = Date.current
      couch.nights << create(:night, date: date)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)

      visit root_path

      fill_in "Destination", with: city
      fill_in "Check In", with: date
      fill_in "Check Out", with: date.tomorrow
      click_on "Find Pad"

      expect(current_path).to eq("/#{city}/couches")
      expect(page).to have_content "1 couch in #{city} available on #{date}"

      click_on "Reserve"

      expect(page).to have_content "#{couch.name} reserved on #{date}."
      expect(page).to have_content "My Travel Reservations"
      expect(page).to have_content "Confirmed"
      expect(page).to have_link "#{couch.name}", href: couch_path(couch)
    end
  end
end
