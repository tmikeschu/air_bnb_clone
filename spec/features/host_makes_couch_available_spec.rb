require 'rails_helper'

RSpec.feature "Host", type: :feature do
  let!(:couch) {create(:couch)}

  it "lists a couch" do
    # As a host with a listed couch
    host = couch.host

    # when I visit that couch listing page
    visit user_couch_path(host, couch)

    # and I click 'Add Availability'
    click_on "Add Availability"

    # and I select the dates I want to make available
     fill_in ".Check_in", with: Date.today.strftime('%m/%d/%Y')
     fill_in ".Check_out", with: Date.tomorrow.strftime('%m/%d/%Y')
    # and I click 'Make Available'
    click_on "Make Available"
    # then I should be back on the listing page
    expect(current_path).to eq(couch_path(couch))
    # and I should see that my couch is available on those dates.
    expect(page).to_have content("Available: #{Date.today.strftime('%m/%d/%Y')}, #{Date.tomorrow.strftime('%m/%d/%Y')}")
  end
end
