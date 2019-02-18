require 'rubygems'
require 'bundler/setup'

# myapp.rb
require 'sinatra'
require 'json'

get '/' do
  output = "Hello world! Version v0.2.1 </br>"
  env_string = JSON.pretty_generate(ENV.to_a).gsub!("\n",'</br>')
  output += "Environment: </br> #{env_string} </br>"
  output
end

get "/google" do
  require "httparty"
  HTTParty.get('http://google.com', follow_redirects: true).body
end
