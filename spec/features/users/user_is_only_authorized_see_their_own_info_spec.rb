require "rails_helper"

RSpec.describe "User Authorization" do
  let!(:user) { create(:user) }

  context "guest" do
    scenario "cannot view a user's dashboard" do
      visit user_path(user)
      expect(page.status_code).to eq(404)
    end

    scenario "cannot make a couch listing as another user" do
      visit new_user_couch_path(user)
      expect(page.status_code).to eq(404)
    end

    scenario "see reservations of another user" do
      visit user_reservations_path(user)
      expect(page.status_code).to eq(404)
    end
  end

  context "traveler" do
    let!(:other) { create(:user) }

    before do
      stub_login(user)
    end

    scenario "cannot view a different user's dashboard" do
      visit user_path(other)
      expect(page.status_code).to eq(404)
    end

    scenario "cannot make a couch listing as another user" do
      visit new_user_couch_path(other)
      expect(page.status_code).to eq(404)
    end

    scenario "see reservations of another user" do
      visit user_reservations_path(other)
      expect(page.status_code).to eq(404)
    end
  end
end
