require 'tilt/erubi'
require "sinatra"
require "sinatra/reloader"

get "/" do
  @contents = Dir.glob("public/*")

  erb :list
end
