require 'sinatra'
require 'byebug'
require 'sinatra/activerecord'
require 'sinatra/contrib'
require 'sinatra/flash'
require './config/environments'
require './models/user'
require './models/school'

module Sinatra
  class Server < Sinatra::Base
    use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'your_secret'
    enable :sessions
    set :sessions, :domain => '.u-vote.org'
    register Sinatra::Flash

    get "/" do
      puts "session domain: #{session[:user_domain]}"
      erb :index
    end

    get "/register" do
      erb :register
    end

    get "/rankings" do

      puts "sessions domain in /rankings: #{session[:user_domain]}"
      @user_domain = session[:user_domain]
      if @user_domain.nil?
        puts "this domain is nil"
        @user_school = nil
      else
        user_school = School.where('webaddr ILIKE ?', "%#{@user_domain}%").limit(1)
        @user_school = user_school[0]
      end
      @schools = School.order(participation: :desc)
      @schools_participation = School.where("participation > 0")
      @schools_avg = []
      @schools_participation.each do |school|
        @schools_avg.push(
          school.participation.to_f / school.enrollment2015.to_f
        )
      end
      @RRavg = (@schools_avg.inject { |sum,el| sum + el}.to_f / @schools_avg.size).to_f
      byebug
      @top_five_schools = School.order("participation DESC limit 5").reverse
      puts "average for all schools is currently #{@RRavg}"

      if params[:search_form]
        puts "search params: #{params[:search_form]}"
        results = School.search(params[:search_form]).order("participation ASC")
        @searchResults = []
        results.each do |result|
          puts "#{result.instnm}: participation: #{result.participation}, enrollment: #{result.enrollment2015} (#{result.countynm})"
          @searchResults.push({
            school:result.instnm,
            enrollment2015: result.enrollment2015,
            participation: result.participation,
            countynm: result.countynm
            })
        end
        puts "search results: #{@searchResults}"
      end
      erb :rankings
    end


    post "/validate" do
      puts "these are the post params: #{params}"
      puts params[:email].length
      if params[:email].empty?
        puts "this email should be blank: #{@email}"
        flash[:fail] = "Oops! Make sure you're using your academic email address."
        redirect "/"
      elsif params[:email].length < 7
        puts "this email should be a bad address: #{@email}"
        flash[:fail] = "Oops! Make sure you're using your academic email address."
        redirect "/"
      else
        fullDomain = params[:email].match(/(?<=@)[\w+.-]+/)
        puts "This is the full domain: #{fullDomain}"
        domainArr = fullDomain.to_s.split(".")
        domain = "#{domainArr[domainArr.length-2]}.#{domainArr[domainArr.length-1]}"
        if domain == "."
          domain = nil
        else
        # this checks to see if there is a school associated with the user's email domain.
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

              session[:user_domain] = @domain
              # cookies[:user_domain] = @domain
              # puts "cookies.domain values = #{cookies[:user_domain]}"
              puts "sessions.domain values = #{session[:user_domain]}"
              flash[:success] = "Way to rep your school!"
              redirect "/"
            end
        else
          puts "failed email is #{@email}"
          flash[:fail] = "Oops! Make sure you're using your academic email address."
          redirect "/"
        end
        end
      end
    end

    get "/participation" do
      erb :participation
    end

    get "/abroad" do
      # redirect "https://register.avaaz.org/"
      erb :abroad
    end

  end #end of Sinatra model
end
