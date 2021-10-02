# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Retrieve < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "customer_retrieve"

        string :customer_id

        def execute
          raise request_error_message(request, OPERATION_TYPE, customer_id) unless request.success?

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
