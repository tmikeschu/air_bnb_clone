require 'rails_helper'

describe "Viewing reservations" do
  let!(:traveler)    { create(:user, first_name: "Traveler name") }
  let!(:host)        { create(:user, first_name: "Host name") }
  let!(:couch)       { create(:couch, host: host) }
  let!(:tomorrow)    { Date.current + 1.days }
  let!(:night)       { create(:night, date: tomorrow, reservation: nil, couch: couch) }
  let!(:reservation) { traveler.reservations.create(status: "confirmed") }
  before do
    reservation.nights << night
  end

  context "as a host" do
    scenario "I can view all the reservations booked on my couches" do
      stub_login(host)
      visit user_reservations_path(host)

      expect(page).to have_content "My Hosting Reservations"
      expect(page).to have_content reservation.couch_name
      expect(page).to have_content reservation.check_in
      expect(page).to have_content reservation.check_out
    end
  end

  scenario "I can view all reservations I have booked as a traveler, and all reservations booked on my couches where I am the host" do
    other_host = create(:user, first_name: "Other host")
    other_couch = create(:couch)
    other_night = create(:night, date: (Date.current + 2.days))
    host_as_traveler_reservation = host.reservations.create(status: "confirmed")

    other_host.couches << other_couch
    other_couch.nights << other_night
    host_as_traveler_reservation.nights << other_night

    stub_login(host)
    visit user_reservations_path(host)

    expect(page).to have_content reservation.couch_name
    expect(page).to have_content reservation.check_in
    expect(page).to have_content reservation.check_out

    expect(page).to have_content host_as_traveler_reservation.couch_name
    expect(page).to have_content host_as_traveler_reservation.check_in
    expect(page).to have_content host_as_traveler_reservation.check_out
  end
end
