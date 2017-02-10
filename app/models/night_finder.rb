class NightFinder
  def initialize(night_params)
    @_night_params = night_params
  end

  def self.find(night_params)
    new(night_params).find_nights
  end

  def find_nights
    Night.all_for_couch(couch_id)
      .between_check_in_check_out(check_in, check_out)
  end

  def couch_id
    night_params["couch_id"]
  end

  def check_in
    night_params["check_in"]
  end

  def check_out
    night_params["check_out"]
  end

  private

    def night_params
      @_night_params
    end
end
