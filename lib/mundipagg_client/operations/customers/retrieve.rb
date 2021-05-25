# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Retrieve < MundipaggClient::MundipaggBase
        string :customer_id

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.get("#{BASE_URL}/customers/#{customer_id}")
        end
      end
    end
  end
end
