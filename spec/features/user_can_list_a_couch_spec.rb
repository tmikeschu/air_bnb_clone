require 'rails_helper'

describe 'User' do
  let!(:user) {create(:user)}

  it 'can have choice to add couch' do
    visit user_path(user)

    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_link("Add a Couch")
  end

  it 'can create a new couch' do
    visit user_path(user)
    click_on("Add a Couch")

    expect(current_path).to eq(new_user_couch_path)
    
    within(".new_couch") do
      fill_in "couch_name", with: "Big Bertha"
      fill_in "couch_street_address", with: "123 Fake St"
      fill_in "couch_city", with: "Toledo"
      fill_in "couch_state", with: "TX"
      fill_in "couch_zipcode", with: "99999"
      click_on "Add Couch"
    end

    couch = Couch.find_by(name: "Big Bertha")

    expect(current_path).to eq(couch_path(couch))
    expect(page).to have_link("Add Availability")
  end

end