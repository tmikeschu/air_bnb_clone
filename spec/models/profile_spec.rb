require 'rails_helper'

RSpec.describe Profile, type: :model do
  context "validations" do
    it { should validate_presence_of :user }
  end

  context "relationships" do
    it { should belong_to :user}
  end

  context "methods" do
    describe "#user_name" do
      it "returns user's first name and last initial" do
        profile = create(:profile)
        user    = profile.user
        expected = "#{user.first_name.capitalize} #{user.last_name[0]}."
        expect(profile.user_name).to eq expected
      end
    end
  end
end
