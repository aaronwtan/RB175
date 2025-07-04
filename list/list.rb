require 'tilt/erubi'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @files = Dir.glob('*', base: 'public')
  @files.sort_by!(&:downcase) if params[:sort] == 'asc'
  @files.sort_by!(&:downcase).reverse! if params[:sort] == 'desc'

  erb :list
end
