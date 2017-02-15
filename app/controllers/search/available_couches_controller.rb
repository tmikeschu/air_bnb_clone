class Search::AvailableCouchesController < ApplicationController
  protect_from_forgery except: :update
  respond_to :html, :js

  def index
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
  end

  def update
    @search_params = search_params
    @query = QueryPresenter.present(search_params)
  end

  private

    def search_params
      params.permit("Check In", "Check Out", "Destination")
    end
end
