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

    def sanitize_numbers(number)
      number.gsub(/[^\d]/, "")
    end

    def sanitize_names(name)
      name = name.gsub(/(á|à|ã|â|ä)/, "a")
                 .gsub(/(é|è|ê|ë)/, "e")
                 .gsub(/(í|ì|î|ï)/, "i")
                 .gsub(/(ó|ò|õ|ô|ö)/, "o")
                 .gsub(/(ú|ù|û|ü)/, "u")
      name = name.gsub(/(Á|À|Ã|Â|Ä)/, "A")
                 .gsub(/(É|È|Ê|Ë)/, "E")
                 .gsub(/(Í|Ì|Î|Ï)/, "I")
                 .gsub(/(Ó|Ò|Õ|Ô|Ö)/, "O")
                 .gsub(/(Ú|Ù|Û|Ü)/, "U")
      name = name.gsub(/ñ/, "n").gsub(/Ñ/, "N")
      name = name.gsub(/ç/, "c").gsub(/Ç/, "C")
      name = name.gsub(/[^A-Z a-z]/, "")
      name.upcase
    end
  end
end
