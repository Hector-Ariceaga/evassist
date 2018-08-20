require 'pry'
class TaskController < ApplicationController

  get '/events/:id/tasks' do
    if Helpers.logged_in?(session)
      @event = Event.find_by_id(params[:id])
      erb :'tasks/index'
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  patch '/events/:id/tasks' do
    @event = Event.find_by_id(params[:id])
    @event.tasks.each do |task|
      if params[:task]
          task.completed = true
          task.save
      else
          task.completed = false
          task.save
      end
    end
    flash[:message] = "Sucessfully saved list status."
    redirect "/events/#{@event.id}/tasks"
  end

  get '/events/:id/tasks/new' do
    @event = Event.find_by_id(params[:id])
    if Helpers.logged_in?(session)
      if Helpers.current_user(session).id.equal?(@event.user.id)
        erb :'tasks/new'
      else
        flash[:message] = "Sorry, you can't add tasks to events you don't own."
      end
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  post '/events/:id/tasks' do
    task = Task.new(params[:task])
    task.event = Event.find_by_id(params[:id])
    task.user_id = session[:user_id]
    if task.save
      flash[:message] = "You have succesfully created a new task!"
      redirect "/tasks/#{task.id}"
    else
      redirect '/tasks/new'
    end
  end

  get '/tasks/:id' do
    if Helpers.logged_in?(session)
      @task = Task.find_by_id(params[:id])
      erb :'tasks/show'
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  get '/tasks/:id/edit' do
    @task = Task.find_by_id(params[:id])
    if Helpers.logged_in?(session)
      if Helpers.current_user(session).id.equal?(@task.user.id)
        erb :'/tasks/edit'
      else
        flash[:message] = "Sorry, you can't edit tasks you don't own."
        redirect "/tasks/#{@task.id}"
      end
    else
      flash[:message] = "Please log in to view content."
      redirect '/login'
    end
  end

  patch '/tasks/:id/edit' do
    task = Task.find_by_id(params[:id])
    if !params[:task][:name].empty?
      task.update(params[:task])
      redirect "/tasks/#{task.id}"
    else
      flash[:message] = "Edit was unsucessful. Please try again."
      redirect "/tasks/#{task.id}/edit"
    end
  end

  delete '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    @user_id = @task.user_id
    if Helpers.current_user(session).id.equal?(@user_id)
      Task.delete(params[:id])
      flash[:message] = "You have succesfully deleted the task."
    else
      flash[:message] = "Sorry, you can't delete a task you don't own!"
    end
    redirect "/events/#{@task.event.id}/tasks"
  end
end
