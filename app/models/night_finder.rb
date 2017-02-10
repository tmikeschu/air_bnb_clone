class NightFinder
  def initialize(night_params)
    @couch_id  = night_params["couch_id"]
    @check_in  = night_params["check_in"]
    @check_out = night_params["check_out"]
  end

  def self.find(night_params)
    NightFinder.new(night_params).find_nights
  end

  def find_nights
    Night.where(couch_id: @couch_id).where(date: Date.parse(@check_in)..Date.parse(@check_out) - 1.day)
  end
end
