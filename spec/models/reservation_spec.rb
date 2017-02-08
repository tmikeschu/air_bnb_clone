require 'rails_helper'

describe Reservation do
  describe "validations" do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:traveler).class_name("User") }
  end
end
