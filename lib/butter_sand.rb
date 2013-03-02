require "butter_sand/client"
require "butter_sand/parser"
require "butter_sand/version"

module ButterSand
  class << self
    def new
      ButterSand::Client.new
    end

    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
  end
end
