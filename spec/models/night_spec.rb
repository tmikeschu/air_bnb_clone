require 'rails_helper'

describe Night do
  describe "validations" do
    it { is_expected.to validate_presence_of(:date) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:reservation) }
    it { is_expected.to belong_to(:couch) }
  end
end
