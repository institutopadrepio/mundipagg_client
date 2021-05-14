# frozen_string_literal: true

require "pry"

module MundipaggClient
  module Operations
    module CreditCards
      class Retrieve < MundipaggClient::MundipaggBase
        string :customer_id
        string :card_id

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.get("#{BASE_URL}/customers/#{customer_id}/cards/#{card_id}")
        end
      end
    end
  end
end
