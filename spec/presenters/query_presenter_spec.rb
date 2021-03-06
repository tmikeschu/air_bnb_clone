require "rails_helper"
include ModelHelpers

describe QueryPresenter do
  let!(:couch) {create(:couch, :phillip)}
  let!(:couch_2) {create(:couch)}

  before do
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    VCR.use_cassette("couch_build_phillip") do
      couch.geocode
      couch.save
    end
    @search_params = {
      "Destination" => couch.city,
      "Check In" => Date.yesterday.to_date_picker_format,
      "Check Out" => Date.tomorrow.to_date_picker_format,
    }
    @presenter = QueryPresenter.new(@search_params)
  end

  describe ".present()" do
    it "returns an instance of QueryPresenter" do
      VCR.use_cassette("couch_near_phillip") do
        expect(QueryPresenter.present(@search_params))
      end
    end
  end

  describe "#couch_count" do
    it "returns count of couches" do
      VCR.use_cassette("couch_near_phillip") do
        expect(@presenter.couch_count).to eq 1
      end
    end
  end

  describe "#city" do
    it "returns a city" do
      expect(@presenter.city).to eq Couch.first.city
    end
  end

  describe "#check_in" do
    it "returns check in date" do
      expect(@presenter.check_in).to eq Date.yesterday.to_date_picker_format
    end
  end

  describe "#check_out" do
    it "returns check out date" do
      expect(@presenter.check_out).to eq Date.tomorrow.to_date_picker_format
    end
  end
end
