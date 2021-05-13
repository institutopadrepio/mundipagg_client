# frozen_string_literal: true

module MundipaggClient
  class MundipaggBase < ActiveInteraction::Base
    API_VERSION = "1"
    BASE_URL = "https://api.mundipagg.com/core/v#{API_VERSION}/"

    def headers
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Authorization" => "Basic #{MundipaggClient::MundipaggClientConfiguration.configuration.api_key}}"
      }
    end

    def connection
      @connection ||= Faraday.new(
        url: "https://api.mundipagg.com/",
        headers: headers
      )
    end
  end
end
