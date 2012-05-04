require 'test_helper'

class ProxyTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    LeadServer
  end

  def test_echos_params_back_in_json
    post '/echo', :foo => :bar

    assert last_response.ok?

    assert_equal 'text/plain', last_response.content_type

    assert_equal JSON.pretty_generate(:foo => :bar), last_response.body
  end
end
