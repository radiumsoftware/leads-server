require './server'

LeadServer.token = ENV['RADIUM_ACCOUNT_TOKEN'] || "665ce0236e9edc4e847b0a754f22106294f93aae"

use Rack::Rewrite do
  rewrite '/', '/index.html'
end
run LeadServer
