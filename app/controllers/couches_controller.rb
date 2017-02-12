class CouchesController < ApplicationController
  def show
    @couch = Couch.find(params[:id])
    @array = ["2017-02-20","2017-02-21","2017-02-22" ]

  end
end