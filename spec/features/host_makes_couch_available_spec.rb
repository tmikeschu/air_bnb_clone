require 'rails_helper'

RSpec.feature "Host", type: :feature do
  let!(:couch) {create(:couch)}

  it "lists a couch" do
    host = couch.host
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit user_couch_path(host, couch)

    click_on "Add Availability"

    today = Date.current.strftime('%m/%d/%Y')
    tomorrow = Date.tomorrow.strftime('%m/%d/%Y')

    fill_in "First Night", with: today
    fill_in "Last Night", with: tomorrow
    click_on "Make Available"

    expect(current_path).to eq(user_couch_path(host, couch))
    x = today.split("/")
    y = "#{x[2]}-#{x[0]}-#{x[1]}"
    expect(page).to have_content(y)
  end
end
