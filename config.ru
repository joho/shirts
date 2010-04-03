require 'sinatra'

set :env,       :production
require 'shirts'
run Sinatra.application