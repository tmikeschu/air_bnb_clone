require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "email must be unique" do
      user = create(:user)
      invalid_user = User.create(email: user.email)

      expect(user).to be_valid
      expect(invalid_user).to be_invalid
    end
  end
end
