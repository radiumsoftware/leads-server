require './server'

LeadServer.token = ENV['RADIUM_ACCOUNT_TOKEN'] || "sandbox" # replace "sandbox" with your own

use Rack::Rewrite do
  rewrite '/', '/index.html'
end
run LeadServer
