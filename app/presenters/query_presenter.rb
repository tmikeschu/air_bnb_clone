class QueryPresenter
  attr_reader :couches,
              :city,
              :check_in,
              :check_out

  def initialize(search_params)
    @search_params = search_params
  end

  def self.present(search_params)
    new(search_params)
  end

  def couches
    Couch.search(@search_params)
  end

  def couch_count
    couches.count
  end

  def city
    @search_params["Destination"]
  end

  def check_in
    @search_params["Check In"]
  end

  def check_out
    @search_params["Check Out"]
  end
end
