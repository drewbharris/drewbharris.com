path = File.expand_path(File.dirname(__FILE__))

require 'rack'
require 'logger'
require "#{path}/lib/controller"
require 'rack/handler'

LOGFILE = "#{path}/rack.log"
PORT = ENV['PORT'] || 9292

# set up the app
controller = Rack::URLMap.new(Controller::URL_MAP)
builder = Rack::Builder.new do
	use(Rack::CommonLogger)
	use(Rack::Static, {:urls => ["/img", "/js", "/css", "/static"], :root => "#{path}/public"})
	Logger.new(LOGFILE)
	run(controller)
end

Rack::Handler.get(:puma).run(builder, :Port => PORT)


