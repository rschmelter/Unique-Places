class UsersController < ApplicationController

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

end
