require 'rails_helper'

describe "Listing reservation messages" do
  let!(:traveler)    { create(:user, first_name: "Traveler name") }
  let!(:host)        { create(:user, first_name: "Host name") }
  let!(:couch)       { create(:couch) }
  let!(:tomorrow)    { Date.current + 1.days }
  let!(:night)       { create(:night, date: tomorrow) }
  let!(:reservation) { traveler.reservations.create(status: "confirmed") }
  before do
    host.couches << couch
    couch.nights << night
    reservation.nights << night
  end

  context "given there are no messages" do
    scenario "an informative sentence is present" do
      stub_login(traveler)
      visit user_reservations_path(traveler)
      click_on couch.id

      expect(page).to have_current_path(user_reservation_path(traveler, reservation))
      expect(page).to have_content couch.name
      expect(page).to have_content traveler.first_name
      expect(page).to have_content host.first_name
      expect(page).to have_content reservation.check_in
      expect(page).to have_content reservation.check_out
      expect(page).to have_content "There are no messages for this reservation yet.  Feel free to send a message."
      expect(page).to have_selector(:link_or_button, "Post message")
    end
  end

  context "given there are messages" do
    let!(:host_message) { create(:message, author: host, reservation: reservation, created_at: Date.current - 1.days) }
    let!(:traveler_message) { create(:message, author: traveler, reservation: reservation, created_at: Date.current) }

    context "when logged in as a traveler" do
      scenario "messages created by both the host and the traveler are shown" do
        stub_login(traveler)
        visit user_reservation_path(traveler, reservation)

        expect(page).not_to have_content "There are no messages for this reservation yet.  Feel free to send a message."
        expect(page).to have_content host_message.content
        expect(page).to have_content traveler_message.content
      end
    end

    context "when logged in as a host" do
      scenario "messages created by both the host and the traveler are shown" do
        stub_login(host)
        visit user_reservation_path(traveler, reservation)

        expect(page).not_to have_content "There are no messages for this reservation yet.  Feel free to send a message."
        expect(page).to have_content host_message.content
        expect(page).to have_content traveler_message.content
      end
    end
  end
end
