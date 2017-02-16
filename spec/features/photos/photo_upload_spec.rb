require 'rails_helper'

RSpec.feature "Photo uploads" do
  context "Host" do
    before do
        Fog.mock!
        Fog::Mock.delay = 0
        service = Fog::Storage.new({
          provider: 'Google',
          google_storage_access_key_id: ENV['google_storage_access_key_id'],
          google_storage_secret_access_key: ENV['google_storage_secret_access_key']
        })
        service.directories.create(:key => 'airbnb-clone')
    end

    scenario "uploads a photo for a couch" do
      VCR.use_cassette ("photos") do
        profile = create :profile
        couch = create :couch, user_id: profile.user_id
        host  = couch.host
        stub_login(host)

        visit user_couch_path(host, couch)
        click_on "Add Couch Photos"

        visit new_couch_photo_path(couch)

        fill_in "Title", with: "My photo title"
        fill_in "Caption", with: "My photo caption"
        attach_file "couch_photo[image]", Rails.root + "spec/fixtures/test_couch.png"
        click_button "Upload"

        filename = "#{couch.photos.last.title}-#{Date.current.to_s}".parameterize
        expect(page).to have_xpath("//img[@src=\"https://storage.googleapis.com/airbnb-clone/#{filename}\"]")
        expect(current_path).to eq(user_couch_path(host, couch))
      end
    end
  end
end
