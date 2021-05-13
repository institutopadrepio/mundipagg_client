# frozen_string_literal: true

module MundipaggClient
  class MundipaggBase < ActiveInteraction::Base
    API_VERSION = "1"
    BASE_URL = "https://api.mundipagg.com/core/v#{API_VERSION}"

    def headers
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    end

    def build_connection
      connection = Faraday.new(headers: headers)
      connection.basic_auth(MundipaggClient::MundipaggClientConfiguration.configuration.api_key, '')
      connection
    end

    def connection
      @connection ||= build_connection
    end
  end
end
