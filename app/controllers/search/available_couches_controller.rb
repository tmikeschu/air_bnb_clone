class Search::AvailableCouchesController < ApplicationController
  def index
    @couches = Couch.search(search_params)
    @city    = params["Destination"]
    @check_in    = params["Check In"]
    @check_out    = params["Check Out"]
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
