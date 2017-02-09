class NightsController < ApplicationController

  def new
    @night = Night.new 
  end
end
