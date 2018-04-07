class AreasController < ApplicationController

  get '/areas' do
    @areas = Area.all
    erb :'/areas/index'
  end

end
