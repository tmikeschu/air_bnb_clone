require 'rails_helper'

RSpec.describe Profile, type: :model do
  context "validations" do
    it { should validate_presence_of :user }
  end

  context "relationships" do
    it { should belong_to :user}
  end
end
