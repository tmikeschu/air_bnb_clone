require 'rails_helper'

RSpec.describe Couch, type: :model do
  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  context "relationships" do
    it { should belong_to(:host).class_name("User") }
  end

end
