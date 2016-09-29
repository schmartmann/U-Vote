require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib'
require 'sinatra/flash'
require './config/environments'
require './models/user'
require './models/school'

module Sinatra
  class Server < Sinatra::Base
    register Sinatra::Contrib
    helpers Sinatra::Cookies
    register Sinatra::Flash

    get "/" do
      cookies[:something] = "foo"
      erb :index
    end

    get "/register" do
      erb :register
    end

    get "/rankings" do
      puts "cookies domain in /rankgins: #{cookies[:domain]}"
      @user_domain = cookies[:domain]
      user_school = School.where('webaddr ILIKE ?', "%#{@user_domain}%").limit(1)
      @user_school = user_school[0]
      @schools = School.all.order(participation: :asc).take(10)
      @average = School.average(:participation)
      @rank = nil
      @top_five_schools = School.all.order(participation: :asc).take(5)
      puts "average for all schools is currently #{@average}"

      if params[:search_form]
        puts "search params: #{params[:search_form]}"
        results = School.search(params[:search_form]).order("participation ASC")
        @searchResults = []
        results.each do |result|
          puts "#{result.instnm}: #{result.participation} (#{result.countynm})"
          @searchResults.push({
            school:result.instnm,
            participation: result.participation,
            countynm: result.countynm
            })
        end
        puts "search results: #{@searchResults}"
      end

      erb :rankings
    end


    post "/validate" do
      fullDomain = params[:email].match(/(?<=@)[\w+.-]+/)
      domainArr = fullDomain.to_s.split(".")
      domain = "#{domainArr[domainArr.length-2]}.#{domainArr[domainArr.length-1]}"
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

          cookies[:domain] = @domain
          puts "cookies.domain values = #{cookies[:domain]}"
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

    get "/abroad" do
      erb :abroad
    end

  end #end of Sinatra model
end
