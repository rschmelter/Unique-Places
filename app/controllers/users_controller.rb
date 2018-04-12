require 'rack-flash'
require 'pry'

class UsersController < ApplicationController
use Rack::Flash

  get '/users/:id' do
    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'/users/show'
    else
      redirect '/areas'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/new'
    else
      redirect to '/areas'
    end

  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      flash[:message] = "Please fill out the username and password field to sign up."
      redirect to '/signup'

    elsif User.find_by(username: params[:username]) != nil
      flash[:message] = "This username is taken. Please choose a different one."
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
      flash[:message] = "You need to sign up for an account before you can login."
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



end
