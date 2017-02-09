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
  end
end
