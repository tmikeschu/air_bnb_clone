class CouchesController < ApplicationController
  def show
    @couch = Couch.find(params[:id])
    gon.available_nights = @couch.available_nights
  end
end