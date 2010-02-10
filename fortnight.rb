require 'sinatra'
require 'haml'
require 'sass'

# turn on smartypants by default
class RDiscount
  def initialize text, *extensions
    @text = text
    @smart = true
    @filter_styles = nil
    @filter_html = nil
    @fold_lines = nil
    extensions.each { |e| e.send("#{e}=", true) }
  end
end
Markdown = RDiscount

set :sass, :style => :compressed

def h template
  haml @template = template
end

get '/' do
  h :index
end

get '/portfolio' do
  h :portfolio
end

get '/contact' do
  h :contact
end

get '/about' do
  h :about
end

get '/application.css' do
  content_type 'text/css'
  sass :stylesheet
end