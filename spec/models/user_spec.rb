require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :phone_number}
    it { should validate_uniqueness_of :phone_number}
  end

  context "relationships" do
    it { should have_many :couches }
  end
end
