class Hello
  def greetings(request, params)
    puts "params = #{params.inspect}\nrequest = #{request.inspect}\n"

    { status: 200, message: 'Hello, World!' }.to_json
  end

  def curse(request, params)
    data = ActiveSupport::JSON.decode(request.body.read)
    puts(data.inspect)
    name = data['name']
    { status: 200, message: "#{name}, you are stupid!" }.to_json
   
  end
end