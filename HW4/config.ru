require './app/pet'

use Rack::Reloader
use Rack::Static, urls: ["/public"]
run Pet