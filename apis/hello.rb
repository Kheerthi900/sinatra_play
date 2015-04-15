class Hello
  def greetings(request, params)
    puts "params = #{params.inspect}\nrequest = #{request.inspect}\n"

    'Hello, World!'
  end

  def curse(request, params)
    data = ActiveSupport::JSON.decode(request.body.read)
    puts(data.inspect)
    name = data['name']
    "#{name}, you are stupid!"
  end
end