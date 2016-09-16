<<<<<<< HEAD
require "sinatra/base"
require 'sinatra/activerecord'
require "sinatra/reloader"
require_relative "server"

run Sinatra::Server
=======
# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application
>>>>>>> 6ced3b5539d646129967fee16c544021c52fafb0
