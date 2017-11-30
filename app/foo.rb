require 'sinatra/base'

class FooApp < Sinatra::Application

  configure do
    set :bind, '0.0.0.0'
  end
  
  get '/' do
    "
      <h1>Visit us @ www.conjur.org!</h1>
      <p>Database Username: #{ENV['DB_USERNAME']}</p>
      <p>Database Password: #{ENV['DB_PASSWORD']}</p>
      <p>Stripe API Key: #{ENV['STRIPE_API_KEY']}</p>
    "
  end

end
