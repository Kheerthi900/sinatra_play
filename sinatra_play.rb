require 'sinatra'
require 'config_service'

Dir.entries('.').select { |x| File.directory?(x)  && x != '.' && x != '..' }.each  do |sub_path|
  rb_files =  Dir.glob("#{File.expand_path('.')}/#{sub_path}/*.rb")
  rb_files.each { |rb_file| require rb_file }
end

routes = ConfigService.load_config('routes.yml')
puts "routes = #{routes.inspect}"


routes.each do |route|
  route_url = (route['url'] =~ /^%r{/)? route['url'] : "'#{route['url']}'"

  puts "route = #{"#{route['action']} #{route_url}"}"

  eval("#{route['action']} #{route_url} do 
    #{route['api_class']} .new.send( '#{route['api_method']}', request, params) 
  end ") 
end
