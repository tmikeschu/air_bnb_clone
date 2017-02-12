class Search::AvailableCouchesController < ApplicationController
  def index
    @query = QueryPresenter.present(search_params)
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
