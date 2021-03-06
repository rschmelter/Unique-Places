require 'rack-flash'

class AreasController < ApplicationController
use Rack::Flash


  get '/areas' do
    if !logged_in?
      redirect to '/login'
    else
      @areas = Area.all
      erb :'/areas/index'
    end
  end

  get '/areas/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/areas/new'
    end
  end

  get "/areas/:id/edit" do
    if !logged_in?
      redirect to '/login'
    else
      @area = Area.find_by_id(params[:id])
    end

    if @area && @area.user == current_user
      erb :'/areas/edit'
    else
      redirect to '/areas'
    end
  end

  post '/areas/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @area = Area.find_by_id(params[:id])
    end
    if params[:country_name] == "" || params[:city_name] == ""
      flash[:message] = "Please fill out the country and city name to edit this area"
      redirect to "areas/#{@area.id}/edit"
    else
      @area.update(country_name: params[:country_name], city_name: params[:city_name])
      redirect to "/areas/#{@area.id}"
    end
  end
  get '/areas/:id' do
    if !logged_in?
      redirect to "/login"
    else
      @area = Area.find(params[:id])
      erb :'/areas/show'
    end
  end

  post '/areas' do
    if !logged_in?
      redirect to '/login'
    elsif
      params[:country_name] == "" || params[:city_name] == ""
      flash[:message] = "Please fill out the country and city name to create this area"
      redirect to '/areas/new'
    else
      @area = Area.new(country_name: params[:country_name], city_name: params[:city_name])

      @area.user_id = current_user.id
      @area.save
      redirect to "/areas/#{@area.id}"
    end
  end






end
