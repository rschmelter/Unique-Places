class PlacesController < ApplicationController

  get '/places' do
    if !logged_in?
      redirect to '/login'
    else
      @places = Place.all
      erb :'places/index'
    end
  end

end
