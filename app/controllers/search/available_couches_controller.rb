class Search::AvailableCouchesController < ApplicationController
  def index
    # byebug
    @query   = QueryPresenter.present(search_params)
    @couches = @query.couches.paginate(page: params[:page], per_page: 4)
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
