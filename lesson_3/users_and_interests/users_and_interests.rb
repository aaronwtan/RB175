require 'yaml'

require 'tilt/erubi'
require 'sinatra'
require 'sinatra/reloader'

before do
  @users = YAML.load_file('users.yaml')
end

get "/" do
  redirect "/users"
end

get "/users" do
  @title = 'Users and Interests'

  erb :users
end

get "/users/:name" do
  @name, @email, @interests, @other_users = parse_users

  erb :user
end

helpers do
  def count_interests
    @users.values.reduce(0) { |total, info| total + info[:interests].size }
  end
end

def parse_users
  name = params[:name].to_sym
  email = @users[name][:email]
  interests = @users[name][:interests]
  other_users = @users.keys.reject { |user| user == name }

  [name, email, interests, other_users]
end
