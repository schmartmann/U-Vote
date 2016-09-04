current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get '/users' do
  @users = User.all
end

get '/users/:id' do
  @users = User.find(params[:id])
end

post '/users/:id/new' do
end

post '/users/:id/create' do
  email = params[:email]
  status = params[:status]
  domain = email.match(/(?<=@)[\w+.-]+/)

  @user = User.create(
    email: email,
    domain: domain,
    status: status
  )
  redirect_to "/"
end
