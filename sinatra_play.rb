require 'sinatra'
require 'config_service'
require 'awesome_print'

require_relative 'config/html_statuses'

Dir.entries('.').select { |x| File.directory?(x)  && x != '.' && x != '..'  && x != 'spec' }.each  do |sub_path|
  rb_files =  Dir.glob("#{File.expand_path('.')}/#{sub_path}/*.rb")
  rb_files.each { |rb_file| require rb_file unless rb_file =~ /deploy.rb/ || rb_file =~ /puma.rb/ }
end

class SinatraPlay < Sinatra::Base
 
  routes = ConfigService.load_config('routes.yml')
  puts "routes = #{routes.inspect}"


  routes.each do |route|
    route_url = (route['url'] =~ /^%r{/)? route['url'] : "'#{route['url']}'"

    puts "route = #{"#{route['action']} #{route_url}"}"

    eval("#{route['action']} #{route_url} do 
      response = #{route['api_class']} .new.send( '#{route['api_method']}', request, params)
      status(response[:status])
      response.to_json
    end ") 
  end  
end

