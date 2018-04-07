class AreasController < ApplicationController

  get '/areas' do
    @areas = Area.all
    erb :'/areas/index'
  end

  get '/bags/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/areas/new'
    end
  end





end
