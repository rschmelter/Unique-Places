class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie,  :key => 'rack.session',
                                :path => '/',
                                :secret => 'your_secret'

  end


  get '/' do
    "Hello, World!"
  end
end
