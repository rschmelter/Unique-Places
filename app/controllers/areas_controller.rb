class AreasController < ApplicationController

  get '/areas' do
    @areas = Area.all
    erb :'/areas/index'
  end


  get '/areas/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/areas/new'
    end
  end

  post '/areas' do
    if !logged_in?
      redirect to '/login'
    elsif
      params[:country_name] == "" || params[:city_name] == ""
      redirect to '/areas/new'
    else
      @area = Area.new(country_name: params[:country_name], city_name: params[:city_name])
      @area.user_id = current_user.id
      @area.save
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





end
