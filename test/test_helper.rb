require 'minitest/unit'
require 'minitest/pride'
require 'minitest/autorun'

require 'rack/test'
require 'webmock/minitest'

$: << File.expand_path("../../", __FILE__)

require "server"

LeadServer.set :environment, :test
