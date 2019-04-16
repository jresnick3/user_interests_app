require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @user_data = YAML.load_file("users.yaml")
end

helpers do
  def num_users
    @user_data.size
  end

  def num_of_interests
    @user_data.reduce(0) { |sum, (_, info)| sum + info[:interests].size }
  end
end

get "/" do
  redirect "/users"
end

get "/user" do
  erb :names
end

get "/:name" do
  @name = params[:name].to_sym
  @user_info = @user_data[@name]
  erb :info
end
