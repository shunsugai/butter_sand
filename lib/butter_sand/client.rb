require 'butter_sand'
require 'butter_sand/api/events'
require 'butter_sand/error'
require 'faraday'
require 'faraday_middleware'
require 'faraday/response/raise_butter_sand_error'

module ButterSand
  class Client
    include ButterSand::API::Events

    ROOT_URL = 'https://www.rokkatei-eshop.com/'

    def get(path)
      request(:get, path)
    end

    private

    def request(method, path)
      response = connection.send(method.to_sym, path)
      response.body
    end

    def connection
      @connection ||= Faraday.new ROOT_URL, :ssl => {:verify => false} do |conn|
        conn.use Faraday::Response::RaiseButterSandError
        conn.use Faraday::Adapter::NetHttp
      end
    end
  end
end