class QueryPresenter

  def initialize(search_params)
    @_search_params = search_params
  end

  def self.present(search_params)
    new(search_params)
  end

  def couches
    Couch.search(search_params)
  end

  def couch_count
    couches.length
  end

  def city
    search_params["Destination"]
  end

  def check_in
    search_params["Check In"]
  end

  def check_out
    search_params["Check Out"]
  end

  private

    def search_params
      @_search_params
    end
end
