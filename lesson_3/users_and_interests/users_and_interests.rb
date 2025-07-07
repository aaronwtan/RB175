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
  redirect "/users" unless @users.keys.include?(params[:name].to_sym)
  @name, @email, @interests, @other_users = parse_users

  erb :user
end

not_found do
  redirect "/users"
end

helpers do
  def count_interests
    @users.values.reduce(0) { |total, info| total + info[:interests].size }
  end
end

def parse_users
  name = params[:name].to_sym
  user_data = @users[name]

  redirect "/users" unless user_data&.key?(:email) && user_data&.key?(:interests)

  email = user_data[:email]
  interests = user_data[:interests].is_a?(Array) ? user_data[:interests] : []
  other_users = @users.keys.reject { |user| user == name }

  [name, email, interests, other_users]
end
