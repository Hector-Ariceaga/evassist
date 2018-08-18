class EventController < ApplicationController
  use Rack::Flash

  get '/events' do
    if Helpers.logged_in?(session)
      @user = User.find_by_id(session[:user_id])
      erb :'/events/index'
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  get '/events/new' do
    if Helpers.logged_in?(session)
      erb :'/events/new'
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  post '/events' do
    event = Event.new(params[:event])
    event.user_id = session[:user_id]
    if event.save
      flash[:message] = "You have succesfully created a new event!"
      redirect "/events/#{event.id}"
    else
      redirect '/events/new'
    end
  end

  get '/events/:id' do
    if Helpers.logged_in?(session)
      @event = Event.find_by_id(params[:id])
      erb :'/events/show'
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  get '/events/:id/edit' do
    @event = Event.find_by_id(params[:id])
    if Helpers.logged_in?(session)
      if Helpers.current_user(session).id.equal?(@event.user.id)
        erb :'/events/edit'
      else
        flash[:message] = "Sorry, you can't edit tasks you don't own."
      end
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  patch '/events/:id/edit' do
    event = Event.find_by_id(params[:id])
    if !params[:event][:name].empty?
      event.update(params[:event])
      flash[:message] = "Successfully updated event."
      redirect "/events/#{event.id}"
    else
      flash[:message] = "Edit was unsucessful. Please try again."
      redirect "/events/#{event.id}/edit"
    end
  end

  delete '/events/:id' do
    @event = Event.find_by_id(params[:id])
    @user_id = @event.user_id
    if Helpers.current_user(session).id.equal?(@user_id)
      Event.delete(params[:id])
      flash[:message] = "You have succesfully deleted the event."
    else
      flash[:message] = "Sorry, you can't delete an event you don't own!"
    end
    redirect "/events"
  end
end
