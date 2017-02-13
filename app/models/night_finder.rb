class NightFinder
  def find_nights(night_params)
    @_night_params = night_params

    Night.all_for_couch(couch_id)
      .between_check_in_check_out(check_in, check_out)
  end

  def self.find(night_params)
    new.find_nights(night_params)
  end

  private

    def night_params
      @_night_params
    end

    def couch_id
      night_params["couch_id"]
    end

    def check_in
      to_date(night_params["check_in"])
    end

    def check_out
      to_date(night_params["check_out"])
    end

    def to_date(string)
      Date.strptime(string, "%m/%d/%Y")
    end
end
