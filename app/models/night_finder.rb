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
    Night.all_for_couch(@couch_id)
      .between_check_in_check_out(@check_in, @check_out)
  end
end
