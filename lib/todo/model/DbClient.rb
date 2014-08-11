require "singleton"
require "cassandra"

class DbClient
  include Singleton

  attr_reader :client

  def initialize
    @client = Cassandra.new('todo', '127.0.0.1:9160')
  end
end
