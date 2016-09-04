require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/user'
require './models/school'
# current_dir = Dir.pwd
# Dir["#{current_dir}/models/*.rb"].each { |file| require file }


module Sinatra
  class Server < Sinatra::Base
    get "/" do
      @users = User.all
      erb :index
    end

    get "/register" do
      erb :register
    end

    get "/rankings" do
      @schools = School.all
      erb :rankings
    end

    get "/participation" do
      erb :participation
    end
  end #end of Sinatra model
end
