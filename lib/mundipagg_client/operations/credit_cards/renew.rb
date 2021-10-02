# frozen_string_literal: true

module MundipaggClient
  module Operations
    module CreditCards
      class Renew < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "credit_card_renew"

        string :customer_id
        string :card_id

        def execute
          raise request_error_message(request, OPERATION_TYPE, card_id) unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.post("#{BASE_URL}/customers/#{customer_id}/cards/#{card_id}/renew")
        end
      end
    end
  end
end
