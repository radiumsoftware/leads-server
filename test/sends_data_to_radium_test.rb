require 'test_helper'

class ProxyTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    LeadServer.token = 'foo'
    LeadServer
  end

  def json
    JSON.dump({ :contact => { :radium => :data }})
  end

  def test_posts_date_with_token_to_radium
    stub_request(:post, "http://api.radiumcrm.com/leads").with({
      :body => {
        "token" => app.token,
        "contact" => { "foo" => "bar" }
      },
      :headers => { 'Accept' => "application/json" }
    }).to_return({
      :status => 200,
      :headers => { "Content-Type" => 'application/json' },
      :body => json
    })

    post '/', :contact => { :foo => :bar }

    assert last_response.ok?

    assert_equal last_response.body, json
  end

  def test_accepts_simplified_data
    stub_request(:post, "http://api.radiumcrm.com/leads").to_return({
      :status => 200,
      :headers => { "Content-Type" => 'application/json' },
      :body => json
    })

    post '/simple', :name => 'foo', :email => 'bar'

    assert last_response.ok?

    assert_equal last_response.body, json
  end

  def test_does_not_include_the_status_from_radium_in_the_headers
    stub_request(:post, "http://api.radiumcrm.com/leads").to_return({
      :status => 200,
      :headers => { "Status" => 200, "Content-Type" => 'application/json' },
      :body => json
    })

    post '/'

    assert_nil last_response.headers['Status']
  end
end
