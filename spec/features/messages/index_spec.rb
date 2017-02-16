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
