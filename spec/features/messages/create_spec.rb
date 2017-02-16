require 'rails_helper'

describe "Creating reservation messages" do
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

  scenario "is unsusseccful with a blank message" do
    stub_login(traveler)
    visit user_reservations_path(traveler)
    click_on couch.id

    expect(page).to have_selector(:link_or_button, "Post message")

    fill_in "message_content", with: ""
    click_on "Post message"

    expect(page).to have_content "Message content can't be blank"
  end


  context "as a traveler" do
    scenario "I can post messages" do
      stub_login(traveler)
      visit user_reservations_path(traveler)
      click_on couch.id

      expect(page).to have_selector(:link_or_button, "Post message")

      fill_in "message_content", with: "Traveler wrote this"
      click_on "Post message"

      message = Message.find_by(author: traveler)
      expect(page).to have_content "Traveler wrote this"
      expect(page).to have_content message.author_name
    end
  end

  context "as a host" do
    scenario "I can post messages" do
      stub_login(host)
      visit user_reservations_path(host)
      click_on couch.id

      expect(page).to have_selector(:link_or_button, "Post message")

      fill_in "message_content", with: "Host wrote this"
      click_on "Post message"

      message = Message.find_by(author: host)
      expect(page).to have_content "Host wrote this"
      expect(page).to have_content message.author_name
    end
  end
end
