require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "requires an email" do
      invalid_user = User.create(email: nil)

      expect(invalid_user).to be_invalid
    end

    it "email must be unique" do
      user = create(:user)
      invalid_user = User.create(email: user.email)

      expect(invalid_user).to be_invalid
    end
  end
end
