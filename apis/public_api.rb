class PublicApi
  def process_get(request, params)
    puts "\n\nrequest = #{request.inspect}\n\nparams = #{params.inspect}\n\n"
    { status: 200, action: :get }.to_json
  end

   def process_post(request, params)
    puts "\n\nrequest = #{request.inspect}\n\nparams = #{params.inspect}\n\n"
    puts "request.body = #{request.body.read}\n\n"
    { status: 200, action: :post }.to_json
  end
end