# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Charges
      class Delete < MundipaggClient::MundipaggBase
        string :charge_id
        integer :amount, default: nil

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

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
