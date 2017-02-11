require 'rails_helper'

describe 'User' do
  let!(:user) {create(:user)}
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(current_path).to eq(new_user_couch_path(user.id))

      within("form") do
        fill_in "Name", with: "#{couch.name} XXL"
        fill_in "Description", with: "#{couch.description}HUGE"
        fill_in "Street address", with: couch.street_address
        fill_in "City", with: couch.city
        fill_in "State", with: couch.state
        fill_in "Zipcode", with: couch.zipcode
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      within("form") do
        fill_in "Name", with: "Bertha XXL"

        fill_in "Street address", with: "123 IDK"
        fill_in "City", with: "Some City"

        fill_in "Zipcode", with: "11111"
        click_on "Add Couch"
      end

      expect(current_path).to eq(new_user_couch_path(user, user.couches.new))
    end
  end
end