ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'models/data_mapper_setup'


class Bookmark < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    erb(:sign_in)
  end

  get '/home' do
    @links = Link.all
    @title = "Home"
    erb(:home)
  end

  get '/add_link' do
    erb(:add_link)
  end

  get '/tags/:name' do
    tag =  Tag.all(name: params[:name])
    @title = params[:name]
    @links = tag.links
    erb(:home)
  end

  post '/new' do
    link = Link.create(title: params[:title], href: params[:href])
    Tag.create_tags(LinkTag,link, params[:tags])
    redirect to('/home')
  end

  get '/new_user' do
    @user = User.new
    @title = "Sign up"
    erb(:new_user)
  end

  post '/new_user' do
    @user = User.new(username: params[:username],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/home')
    else
      # !@user.password.valid
      flash.now[:invalid_password] = "Passwords do not match"
      # @message = :invalid_password
      erb(:new_user)
    # elsif
    #   !email.valid
    #   flash.now[:invalid_email] = "Incorrect email"
    #   @message = :invalid_email
    #   erb(:new_user)
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
