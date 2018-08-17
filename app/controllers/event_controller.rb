class EventController < ApplicationController

  get '/events' do
    erb :'/events/index'
  end

  get '/events/new' do
    erb :'/events/new'
  end

  post '/events' do
    event = Event.new(params[:event])
    event.user_id = session[:user_id]
    if event.save
      redirect "/events/#{event.id}"
    else
      redirect '/events/new'
    end
  end

  get '/events/:id' do
    @event = Event.find_by_id(params[:id])
    erb :'/events/show'
  end

  get '/events/:id/edit' do
    @event = Event.find_by_id(params[:id])
    erb :'/events/edit'
  end

  patch '/events/:id/edit' do
    event = Event.find_by_id(params[:id])
    if !params[:event][:name].empty?
      event.update(params[:event])
      redirect "/events/#{event.id}"
    else
      redirect "/events/#{event.id}/edit"
    end
  end

  delete '/events/:id' do
    Event.delete(params[:id])
    redirect "/events"
  end
end
