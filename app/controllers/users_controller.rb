class UsersController < ApplicationController

  # get '/users/:id' do
  #   # if !logged_in?
  #   #   redirect '/areas'
  #   # end
  #
  #   @user = User.find(params[:id])
  #   if !@user.nil? && @user == current_user
  #     erb :'/users/show'
  #   else
  #     redirect '/areas'
  #   end
  # end

  get '/signup' do
    if !logged_in?
      erb :'/users/new'
    else
      redirect to '/areas'
    end

  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/areas'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/areas'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/areas"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/areas' do
    "Hello World"
  end


end
