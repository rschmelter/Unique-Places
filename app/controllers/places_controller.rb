class PlacesController < ApplicationController
require 'pry'
  get '/places' do
    if !logged_in?
      redirect to '/login'
    else
      @places = Place.all
      erb :'places/index'
    end
  end

  get '/places/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'places/new'
    end
  end

  post '/places' do
    if !logged_in?
      redirect to '/login'
    elsif
      params[:place_type] == "" || params[:name] == "" || params[:description] == ""
      redirect to '/places/new'
    else
      @place = Place.new(place_type: params[:place_type], name: params[:name], description: params[:description])
      @place.area_id = params[:area_id]
      @place.save
      redirect to "/places/#{place.id}"
    end
  end

  get '/places/:id' do
    if !logged_in?
      redirect to "/login"
    else
      @place = Place.find(params[:id])
      erb :'/places/show'
    end

  end


end
