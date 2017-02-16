require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :phone_number}
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :phone_number}
  end

  context "relationships" do
    it { should have_many :couches }
    it { should have_many :reservations }
    it { should have_one :profile }
  end

  describe "#author_name" do
    let!(:user) { create(:user, first_name: "Han", last_name: "Solo") }

    it "returns the first name and last initial for the user" do
      expect(user.author_name).to eq "Han S."
    end
  end
end
