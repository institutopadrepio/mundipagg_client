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
      Faraday.new(headers: headers) do |conn|
        conn.basic_auth(
          MundipaggClient::MundipaggClientConfiguration.configuration.api_key,
          ""
        )
      end
    end

    def connection
      @connection ||= build_connection
    end

    def sanitize_numbers(number)
      number.gsub(/[^\d]/, "")
    end

    def sanitize_names(name)
      from = "àáäâãèéëẽêìíïîĩòóöôõùúüûũñçñÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÑÇ"
      to = "aaaaaeeeeeiiiiiooooouuuuuncnAAAAAEEEEIIIIOOOOOUUUUNC"
      name.gsub(/[#{from}]/, from.split("").zip(to.split("")).to_h).gsub(/[^A-Z a-z]/, "").upcase
    end

    def request_error_message(request, operation_type, id = nil)
      "MundipaggClientError on #{operation_type}, message: #{JSON.parse(request.body)["message"]}"\
      "#{id.present? ? ", id: #{id}" : ""}"
    end
  end
end
