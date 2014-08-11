ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

$LOAD_PATH.unshift File.expand_path( "../../lib", __FILE__ )

require 'todo/app'

describe 'Todo App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "provides all created todo items" do
    get '/'
    expect(last_response.body).to include("brew some coffee")
  end
end
