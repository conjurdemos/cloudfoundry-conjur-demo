require 'sinatra/base'

class TestApp < Sinatra::Application

  configure do
    set :bind, '0.0.0.0'
  end
  
  get '/' do
    "
      <h1>Visit us @ www.conjur.org!</h1>

      <h3>Org-wide Secrets</h3>
      <p>Database Username: #{ENV['ORG_DB_USERNAME']}</p>
      <p>Database Password: #{ENV['ORG_DB_PASSWORD']}</p>

      <h3>Space-wide Secrets</h3>
      <p>Database Username: #{ENV['SPACE_DB_USERNAME']}</p>
      <p>Database Password: #{ENV['SPACE_DB_PASSWORD']}</p>

      <h3>App-specific Secrets</h3>
      <p>Database Username: #{ENV['APP_DB_USERNAME']}</p>
      <p>Database Password: #{ENV['APP_DB_PASSWORD']}</p>
      <p>Stripe API Key: #{ENV['STRIPE_API_KEY']}</p>
    "
  end

end
