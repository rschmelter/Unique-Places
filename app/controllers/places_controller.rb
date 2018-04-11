require 'rack-flash'

class PlacesController < ApplicationController
use Rack::Flash


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
      flash[:message] = "Please fill out all required fields to post this place"
      redirect to '/places/new'
    else
      @place = Place.new(place_type: params[:place_type], name: params[:name], description: params[:description])
      @place.area_id = params[:area_id]
      @place.save
      redirect to "/places/#{@place.id}"
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

  get '/places/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @place = Place.find_by_id(params[:id])
    end

    if @place && @place.area.user_id == current_user.id
      erb :'/places/edit'
    else
      redirect to '/areas'
    end
  end

  post '/places/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @place = Place.find_by_id(params[:id])
    end
    if params[:place_type] == "" || params[:name] == "" || params[:description] == ""
      flash[:message] = "Please fill out all of the fields to edit this place"
      redirect to "places/#{@place.id}/edit"
    else

      @place.update(place_type: params[:place_type], name: params[:name], description: params[:description])
      @place.area_id = params[:area_id]
      @place.save
      redirect to "/places/#{@place.id}"
    end
  end

  delete '/places/:id/delete' do
    if !logged_in?
      redirect to '/login'
    else
      @place = Place.find_by_id(params[:id])
    end
    if @place && @place.area.user_id == current_user.id
      @place.delete
      redirect to '/places'
    else
      redirect to '/login'
    end

  end






end
