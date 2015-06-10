require_relative '../spec_helper'

describe SinatraPlay do
   before do
    Capybara.app = SinatraPlay
  end
  describe 'curse' do
    it 'curses correctly with name' do
      post('/curse', { name: 'Batman'}.to_json, {'CONTENT_TYPE' => 'application/json' })
      # if we use
      # class MiniTest::Spec
      #   include Capybara::DSL
      #   include Capybara::Json
      # end

      # Capybara.current_driver = :rack_test_json
      # then use the json code below
      # json['status'].must_equal 200
      # json['message'].must_equal 'Batman, you are stupid!'
      last_response.ok?.must_equal true
      ActiveSupport::JSON.decode(last_response.body).must_equal({ 'status' => 200, 'message' => 'Batman, you are stupid!' })
    end

    it 'returns Unprocessable Entity if name is empty' do 
      post('/curse', {}.to_json, {'CONTENT_TYPE' => 'application/json' })
      last_response.ok?.must_equal false
      last_response.status.must_equal HTML_CODES['Unprocessable Entity']
      ActiveSupport::JSON.decode(last_response.body).must_equal({ 'status' => 422, 'message' => 'Name cannot be blank.' })
    end
  end

  describe 'root' do
    it 'says Hello, World!' do
      get '/'

      # if we use
      # class MiniTest::Spec
      #   include Capybara::DSL
      #   include Capybara::Json
      # end

      # Capybara.current_driver = :rack_test_json
      # then use the json code below
      #json['status'].must_equal 200
      #json['message'].must_equal 'Hello, World!'

      last_response.ok?.must_equal true
      last_response.body.must_equal '{"status":200,"message":"Hello, World!"}'
    end
  end
end