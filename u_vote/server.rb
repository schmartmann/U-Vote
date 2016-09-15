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
      domain = params[:email].match(/(?<=@)[\w+.-]+/)
      if School.exists?(['webaddr ILIKE ?', "%#{domain}%"]) and domain.nil? == false
        @domain = domain
        @email = params[:email]
        if User.exists?(['email ILIKE ?', "%#{@email}%"])
          flash[:dupe] = "Looks like you've already repped your school! Get the word out!"
          redirect "/"
        else
          @status = params[:status]

          @user = User.create(
          email: @email,
          domain: @domain,
          status:@status)

          school = School.find_by(['webaddr ILIKE ?', "%#{@domain}%"])
          school.increment!(:participation, by = 1)
          puts "#{school.instnm} participation: #{school.participation}"

          user = User.last
          puts user.email
          flash[:success] = "Way to rep your school!"
          redirect "/"
        end
      else
        puts "failed email is #{@email}"
        flash[:fail] = "Oops! Make sure you're using your academic email address."
        redirect "/"
      end
    end

    get "/participation" do
      erb :participation
    end
  end #end of Sinatra model
end
