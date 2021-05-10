# frozen_string_literal: true
require 'json'

module MundipaggClient
  module Services
    module Operations
      module Customers
        class Create < MundipaggClient::MundipaggBase
          def execute
            raise "Invalid Mundipagg transaction" unless mundipagg_charge.success?

            JSON.parse(mundipagg_charge.body)
          end

          private

          def mundipagg_charge
            @mundipagg_charge ||= Faraday.post(
              "#{BASE_URL}/charges",
              charge_params.to_json,
              "Content-Type" => "application/json"
            )
          end

          def charge_params
          end
        end
      end
    end
  end
end
