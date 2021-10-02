# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Charges
      class Delete < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "charge_refund"

        string :charge_id
        integer :amount, default: nil

        def execute
          raise request_error_message(request, OPERATION_TYPE, charge_id) unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.delete("#{BASE_URL}/charges/#{charge_id}") do |req|
            req.body = { amount: amount }.to_json unless amount.nil?
          end
        end
      end
    end
  end
end
