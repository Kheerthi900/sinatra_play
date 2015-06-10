class Hello
  def greetings(request, params)
    puts "params = #{params.inspect}\nrequest = #{request.inspect}\n"
    ap request.env

    { status: 200, message: 'Hello, World!' }
  end

  def curse(request, params)
    data = ActiveSupport::JSON.decode(request.body.read)
    if data.empty?
      return { status: HTML_CODES['Unprocessable Entity'], message: 'Name cannot be blank.' }
    end

    ap data
    name = data['name']
    { status: 200, message: "#{name}, you are stupid!" }
   
  end
end