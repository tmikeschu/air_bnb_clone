require 'rails_helper'

RSpec.feature "Nights", type: :feature do
  let!(:profile) { create(:profile) }
  let!(:couch)   { create(:couch, user_id: profile.user_id) }

  scenario "host lists a couch" do

    host = couch.host
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit user_couch_path(host, couch)

    click_on "Add Availability"

    today = Date.current.strftime('%m/%d/%Y')
    next_month = Date.current.next_month.strftime('%m/%d/%Y')

    fill_in "First Night", with: today
    fill_in "Last Night", with: next_month
    click_on "Make Available"

    expect(current_path).to eq(user_couch_path(host, couch))
    start = today.split("/")
    start_format = "#{start[2]}-#{start[0]}-#{start[1]}"
    last = next_month.split("/")
    last_format = "#{last[2]}-#{last[0]}-#{last[1]}"

    expect(page).to have_content(start_format)
    expect(page).to have_content(last_format)
  end

  describe "SAD path" do
    scenario "date can't be in past" do
      host = couch.host
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

      visit user_couch_path(host, couch)

      click_on "Add Availability"

      last_week = (1.week.ago).strftime('%m/%d/%Y')
      next_month = Date.current.next_month.strftime('%m/%d/%Y')

      fill_in "First Night", with: last_week
      fill_in "Last Night", with: next_month
      click_on "Make Available"

      last = next_month.split("/")
      last_format = "#{last[2]}-#{last[0]}-#{last[1]}"


      expect(current_path).to eq(new_couch_night_path(couch))
      expect(page).to have_content("Date can't be in the past")
      expect(page).to_not have_content(last_format)
    end
  end
end
