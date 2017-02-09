require 'rails_helper'

RSpec.feature "Host", type: :feature do
  let!(:couch) {create(:couch)}

  it "lists a couch" do
    # As a host with a listed couch
    host = couch.host
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    # when I visit that couch listing page
    visit user_couch_path(host, couch)

    # and I click 'Add Availability'
    click_on "Add Availability"

    # and I select the dates I want to make available
    today = Date.today.strftime('%m/%d/%Y')
    tomorrow = Date.tomorrow.strftime('%m/%d/%Y')
    save_and_open_page
    fill_in "First Night", with: today
    fill_in "Last Night", with: tomorrow
    # and I click 'Make Available'
    click_on "Make Available"
    # then I should be back on the listing page
    expect(current_path).to eq(couch_path(couch))
    # and I should see that my couch is available on those dates.
    expect(page).to_have content("Available: #{today}, #{tomorrow}")
  end
end
