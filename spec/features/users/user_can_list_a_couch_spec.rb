require 'rails_helper'

describe 'User' do
  let!(:profile) { create(:profile)}
  let!(:user)    { profile.user}

  before do
    stub_login(user)
  end

  context 'can host couches from their page' do
    it 'can have choice to add couch' do
      visit user_path(user)

      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_link("Add a Couch")
    end

    it 'can create a new couch' do
      couch = create(:couch)
      visit user_path(user)
      click_on("Add a Couch")

      expect(current_path).to eq(new_user_couch_path(user.id))

      within("form") do
        fill_in "couch_name", with: "#{couch.name} XXL"
        fill_in "couch_description", with: "#{couch.description}HUGE"
        fill_in "couch_street_address", with: couch.street_address
        fill_in "couch_city", with: couch.city
        fill_in "couch_state", with: couch.state
        fill_in "couch_zipcode", with: couch.zipcode
        click_on "Add Couch"
      end

      couch = Couch.last

      expect(current_path).to eq(user_couch_path(user, couch))
      expect(page).to have_link("Add Availability")
    end
  end

  context 'sad path' do
    it 'will re route to new couch path' do
      visit user_path(user)
      click_on "Add a Couch"

      within("form") do
        fill_in "couch_name", with: "Bertha XXL"

        fill_in "couch_street_address", with: "123 IDK"
        fill_in "couch_city", with: "Some City"

        fill_in "couch_zipcode", with: "11111"
        click_on "Add Couch"
      end

      expect(current_path).to eq(new_user_couch_path(user, user.couches.new))
    end
  end
end
