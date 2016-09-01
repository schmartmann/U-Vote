require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/user'

module Sinatra
  class Server < Sinatra::Base
    get "/" do
      erb :index
    end

    get "/register" do
      erb :register
    end

    get "/rankings" do
      erb :rankings
    end

    get "/participation" do
      erb :participation
    end
  end #end of Sinatra model
end
