class UserController < ApplicationController
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      flash[:message] = "You are already signed up!"
      redirect '/events'
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    user = User.new(params)

    if user.save
      session[:user_id] = user.id
      redirect '/events'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      flash[:message] = "You are already logged in!"
      redirect '/events'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/events"
    else
      flash[:message] = "Username or password incorrect. Please try again."
      redirect "/login"
    end
  end

  get '/users/:slug' do
    if Helpers.logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
