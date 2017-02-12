require "rails_helper"

describe QueryPresenter do
  before do
    couch = create(:couch)
    couch_2 = create(:couch)
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    @search_params = {
      "Destination" => couch.city,
      "Check In"    => Date.yesterday.to_s,
      "Check Out"   => Date.tomorrow.to_s
    }
    @presenter = QueryPresenter.new(@search_params)
  end

  describe ".present()" do
    it "returns an instance of QueryPresenter" do
      expect(QueryPresenter.present(@search_params))
    end
  end

  describe "#couches" do
    it "returns couch objects" do
      expect(@presenter.couches).to be_a Couch::ActiveRecord_Relation
    end
  end

  describe "#couch_count" do
    it "returns count of couches" do
      expect(@presenter.couch_count).to eq 1
    end
  end

  describe "#city" do
    it "returns a city" do
      expect(@presenter.city).to eq Couch.first.city
    end
  end

  describe "#check_in" do
    it "returns check in date" do
      expect(@presenter.check_in).to eq Date.yesterday.to_s
    end
  end

  describe "#check_out" do
    it "returns check out date" do
      expect(@presenter.check_out).to eq Date.tomorrow.to_s
    end
  end
end
