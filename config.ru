require 'bundler/setup'
Bundler.require
class Harness < Sinatra::Base
  enable :static
  set :public_folder, proc {root}

  get '/' do
    redirect to '/demo.html'
  end

  get '/drag.js' do
    content_type 'text/javascript'
    CoffeeScript.compile File.read File.join self.class.root, 'drag.coffee'
  end

  get '/drag2.js' do
    content_type 'text/javascript'
    CoffeeScript.compile File.read File.join self.class.root, 'drag2.coffee'
  end

  get '/harness.js' do
    content_type 'text/javascript'
    CoffeeScript.compile File.read File.join self.class.root, 'harness.coffee'
  end
end

run Harness.new
