require "sinatra/base"
require 'sinatra/activerecord'
# require "sinatra/reloader"
require_relative "server"

run Sinatra::Server
