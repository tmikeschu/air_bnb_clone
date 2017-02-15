require 'rails_helper'

describe Message do
  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:reservation) }
    it { is_expected.to belong_to(:author).class_name("User") }
  end
end
