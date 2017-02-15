class Search::AvailableCouchesController < ApplicationController
  def index
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
