# Start with:
# $ thin -R socky.ru -p 3001 start
current_dir = File.expand_path(File.dirname(__FILE__))
#require current_dir + '/lib/socky/server'

require './lib/socky/server'
options = {
  :debug => true,
  :applications => {
    :my_app => {
      :secret => 'my_secret',
      :webhook_url => 'http://localhost:3000/callback/url/'
    }
  }
}

map '/websocket' do
  run Socky::Server::WebSocket.new options
end

map '/http' do
  use Rack::CommonLogger
  run Socky::Server::HTTP.new options
end