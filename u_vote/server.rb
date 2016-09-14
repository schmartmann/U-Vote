require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './config/environments'
require './models/user'
require './models/school'

module Sinatra
  class Server < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    get "/" do
      @users = User.all
      @email
      erb :index
    end

    get "/register" do
      erb :register
    end

    get "/rankings" do
      @schools = School.all
      erb :rankings
    end

    post "/validate" do
      @status = params[:status]
      @email = params[:email]
      domain = params[:email].match(/(?<=@)[\w+.-]+/)

      if School.exists?(['webaddr ILIKE ?', "%#{domain}%"]) and domain.nil? == false
        @domain = domain
        @user = User.create(
        email: @email,
        domain: @domain,
        status:@status)
        flash[:success] = "Way to rep your school!"
        @email
        redirect "/"
      else
        puts "failed email is #{@email}"
        @email
        flash[:fail] = "Oops! Make sure you're using your academic email address."
        redirect "/"
      end
    end

    get "/participation" do
      erb :participation
    end
  end #end of Sinatra model
end
