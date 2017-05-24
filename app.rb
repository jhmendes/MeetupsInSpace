require 'sinatra'
require_relative 'config/application'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(:name)
  erb :'meetups/index'
end

get '/meetups/new' do
  @errors = []

  @meetup = Meetup.new
  erb :'meetups/new'
end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  @members = @meetup.users
  @username = @meetup.creator
  erb :'meetups/show'
end

post '/meetups/join/:id' do
  @meetup = Meetup.find(params[:id])
  @members = @meetup.users
  erb :'meetups/show'

  if current_user.nil?
    @sign_in = "You must be signed in to join this group"
    erb :'meetups/show'
  else
    @joined = "You've successfully joined this meetup! Welcome to the group."
    @new_membership = Membership.create(user_id: current_user.id, meetup_id: @meetup.id)
    erb :'meetups/show'
  end

end


post '/meetups/new' do
  @members = []
  @username = current_user.username
  params[:meetup][:creator] = @username
  @meetup = Meetup.create(params[:meetup])
    if @meetup.valid?
      @message = "You've successfully created a meetup!"
      erb :'meetups/show'
    else
      @errors = @meetup.errors.full_messages
      erb :'meetups/new'
    end
end
