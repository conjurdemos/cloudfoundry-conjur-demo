require 'sinatra/base'

class TestApp < Sinatra::Application

  configure do
    set :bind, '0.0.0.0'
  end
  
  get '/' do
    "
      <h1>Visit us @ www.conjur.org!</h1>

      <p>App secret: #{ENV['DEMO_SECRET']}</p>
    "
  end

end
