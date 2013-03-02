require 'faraday'

module Faraday
  class Response::RaiseButterSandError < Response::Middleware
    def on_complete(response)
      case response[:status]
      when 400
        raise ButterSand::BadRequest, error_message(response)
      when 401
        raise ButterSand::Unauthorized, error_message(response)
      when 403
        raise ButterSand::Forbidden, error_message(response)
      when 404
        raise ButterSand::NotFound, error_message(response)
      when 406
        raise ButterSand::NotAcceptable, error_message(response)
      when 500
        raise ButterSand::InternalServerError, error_message(response)
      when 503
        raise ButterSand::ServiceUnavailable, error_message(response)
      end
    end

    private

    def error_message(response)
      message = response[:body]['error']
      return message unless message.empty?
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}"
    end
  end
end