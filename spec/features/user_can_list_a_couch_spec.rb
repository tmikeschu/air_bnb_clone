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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    couch = create(:couch)
    visit user_path(user)
    click_on("Add a Couch")

    expect(current_path).to eq(new_user_couch_path(user.id))

    within(".new_couch") do
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