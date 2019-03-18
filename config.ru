require './config/environment'

use Rack::MethodOverride
use EventController
use TaskController
use UserController
run ApplicationController
