class Search::AvailableCouchesController < ApplicationController
  def index
    @query = QueryPresenter.present(search_params)
    gon.push({
      :google_api => ENV['google_maps_api']
    })
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
