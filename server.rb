require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'faraday'
require 'faraday_middleware'
require 'rack/rewrite'

class RadiumConnection
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def post(parameters = {})
    connection.post "/leads", parameters.merge(:token => token)
  end

  private
  def connection
    builder = Faraday.new "http://api.radiumcrm.com" do |conn|
      conn.request :url_encoded
      conn.response :json, :content_type => /\bjson$/

      conn.adapter Faraday.default_adapter
    end

    builder.headers['Accept'] = 'application/json'
    builder
  end
end

class LeadServer < Sinatra::Application
  def self.token
    @token
  end

  def self.token=(token)
    @token = token
  end

  post '/' do
    connection = RadiumConnection.new self.class.token
    radium_response = connection.post params

    radium_response.headers.delete('status')

    headers radium_response.headers
    status radium_response.status
    body JSON.dump(radium_response.body)
  end

  post '/simple' do
    contact_params = { :contact => {
      :name => params[:name],
      :email_addresses_attributes => [{
        :name => "Personal",
        :value => params[:email]
      }]
    }}

    connection = RadiumConnection.new self.class.token
    radium_response = connection.post contact_params

    radium_response.headers.delete('status')

    headers radium_response.headers
    status radium_response.status
    body JSON.dump(radium_response.body)
  end

  post '/echo' do
    status 200
    headers "Content-Type" => "text/plain"
    body JSON.pretty_generate(params)
  end
end
